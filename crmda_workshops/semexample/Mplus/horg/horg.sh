#!/usr/bin/env bash
################################################################################
# Name: horg.sh
# Version: 02.8

# Enables a series of emacs functions to be accomplished in shell
#
# Usage: ./horg.sh -options <input-file>
#
# Author: Longcan Huang
# Date: 2018-07-10
################################################################################
# horg stands for 'handling org'.
#
# ------------------------------------------------------------------------------
# After seeing the workflow of horg_v01.sh, pj asked for a few more
# features:
# 1. make the org file reflect whether mplus has run successfully;
# 2. at the end of the html file, add a link to the output file;
# 2.1 the link description should reflect the output file's name.

# The whole work flow needs adjusting because actions were run separatedly and now
# mplus runs inside the updated org file that relies on the result from
# org-babel-tangle; exporting to html should happen after mplus runs in order to
# reflect whether mplus has run successfully and add the the link to the output
# file.
# Therefore, the new workflow should be
# 1. tangle the original orgfile;
# 2. add a section to the orgfile that runs mplus and shows whether it has run
# successfully;
# 3. run the mplus code;
# 4. add a section to the orgfile that links to the output file;
# 5. insert a proper header to make the html file stylish.
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
################################################################################
# 0. 
EMACSCMD="emacs"
# set directories
# DIR="/home/l347h849/semexample-master/test/Mplus/" # option 1
# read -p 'Enter the absolute path where you saved your org files. ' DIR # option 2
# DIR="$(dirname "$(dirname "${BASH_SOURCE[0]}")")" # option 3
SRC_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)/src/"
echo "The emacs-lisp file is located in $SRC_DIR."
SETUP_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P)/setup/"
echo "The org setup files are located in $SETUP_DIR."
# TESTFILE="~/semexample-master/test/Mplus/Ex-01-EFA/efa-01.org"
# echo $TESTFILE
note="You are running org-mode "
# 1. find all the org files in the current directory including the
# subdirectories

# ORGFILES=$(find $DIR -name '*.org')

# 2. run the whole process on one single orgfile;

workflow()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
          (progn
            (require 'crmda-org)
            (message (concat \"$note\" org-version))
            (find-file (expand-file-name \"$1\"))
            (insert-crmda-template \"$SETUP_DIR\")
            ;;(auto-insert-crmda-template)
            (org-babel-tangle)                           
            (con/auto-insert-output-section)
            (save-buffer)
            (kill-buffer)
            (execute-shell-mplus-block \"$1\")
            (find-file (expand-file-name \"$1\"))
            (auto-insert-results-section)
            (save-buffer)
            (kill-buffer)
            (find-file (expand-file-name \"$1\"))
            (org-html-export-to-html)
            (kill-buffer))"
}

# workflow $TESTFILE              # 
# fixed: popout that asks for permission to reread the file on disk because some changes have been made to the file.

# for i in $ORGFILES; do
    # echo $i
    # workflow $i
# done

# to break the workflow down
insert_output()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
    (progn
      (require 'crmda-org)
      (message (concat \"$note\" org-version))
      (find-file (expand-file-name \"$1\"))
      (org-babel-tangle)
      (con/auto-insert-output-section)
      (save-buffer)
      (kill-buffer))" 2>&1 | grep ""
}
# insert_output $TESTFILE

execute_mplus()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
    (progn
      (require 'crmda-org)
      (message (concat \"$note\" org-version))
      (find-file (expand-file-name \"$1\"))
      (execute-shell-mplus-block \"$1\")
      (save-buffer)
      (kill-buffer))" 2>&1 | grep ""
}
# execute_mplus $TESTFILE

insert_results()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
    (progn
      (require 'crmda-org)
      (message (concat \"$note\" org-version))
      (insert-results-section \"$1\")
      (kill-buffer))" 2>&1 | grep ""
}
# insert_results $TESTFILE

export_to_html()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
    (progn
      (require 'crmda-org)
      (message (concat \"$note\" org-version))
      (find-file (expand-file-name \"$1\"))
      (org-html-export-to-html)
      (kill-buffer))" 2>&1 | grep ""
}
# export_to_html $TESTFILE

# 3. loop through the same process for each orgfile found in the directory
# including the subdirectories.

# for i in $ORGFILES; do
#     workflow $i
# done
# 4. add header
insert_title ()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
    (progn
        (require 'crmda-org)
        (message (concat \"$note\" org-version))
        (find-file (expand-file-name \"$1\"))
        (auto-insert-title-header)
        (save-buffer)
        (kill-buffer))" 2>&1 | grep ""
}
# insert_title $TESTFILE

insert_crmda_template ()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
    (progn
        (require 'crmda-org)
        (message (concat \"$note\" org-version))
        (find-file (expand-file-name \"$1\"))
        (insert-crmda-template \"$SETUP_DIR\")
        (save-buffer)
        (kill-buffer))" 2>&1 | grep ""
}
# insert_crmda_template $TESTFILE
################################################################################
################################################################################
tangle_run_export ()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
    (progn
        (require 'crmda-org)
        (message (concat \"$note\" org-version))
        (find-file (expand-file-name \"$1\"))
        (org-babel-tangle)
        (save-buffer)
        (kill-buffer)
        (execute-shell-mplus-block \"$1\")
        (find-file (expand-file-name \"$1\"))   
        (org-html-export-to-html)
        (kill-buffer))
        " 2>&1 | grep ""
}
# tangle_run_export $TESTFILE

ORGFILES=

batch_handle ()
{
read -e -p 'Enter the absolute path where you saved your org files. ' DIR
ORGFILES=$(find $DIR -name '*.org')
for i in $ORGFILES; do
    echo $i
    workflow $i
done
}

export_to_md ()
{
$EMACSCMD -nw --batch --directory "$SRC_DIR" --eval "
    (progn
        (require 'crmda-org)
        (message (concat \"$note\" org-version))
        (find-file (expand-file-name \"$1\"))
        (crmda/org-md-export-to-markdown)
        (kill-buffer))
        " 2>&1 | grep ""
}

usage ()
{
    echo ""
    echo ""
    echo "usage: ./horg.sh [OPTION]...[FILE]..."
    echo "Handle the org FILE (*.org) in multiple ways."
    echo ""
    echo "    -h        show this usage screen"
    echo "    [-u]      {u}pdate and export the FILE"
    echo "    -e        {e}xport the FILE to html "
    echo "    -m        execute the {m}plus source code block in the FILE"
    echo "    -o        insert an {o}utput section to the FILE"
    echo "    -r        insert a {r}esult section to the FILE"
    echo "    -t        insert the crmda {t}emplate to the FILE"
    echo "    -z        {z}ing the FILE"
}

# shift "$(($OPTIND - 1))"
optstring=:hbe:m:o:r:t:u:z:
case "$1" in
    -*)
        # OPTIND=2                # 
        while getopts $optstring opt; do
            case $opt in
                h)
                    usage
                    exit 0
                    ;;
                b)
                    batch_handle
                    ;;
                e)
                    export_to_html $OPTARG
                    ;;
                m)
                    execute_mplus $OPTARG
                    ;;
                o)
                    insert_output $OPTARG
                    ;;
                r)
                    insert_results $OPTARG
                    ;;
                t)
                    insert_crmda_template $OPTARG
                    ;;
                u)
                    tangle_run_export $OPTARG
                    ;;
                z)
                    workflow $OPTARG
                    ;;
                \?)
                    echo "Invalid option: $1"
                    exit
                    ;;
                :)
                    echo "Option $1 requires an argument."
                    exit
                    ;;
            esac
        done
        ;;
    *)
        filename=$(basename -- "$1")
        extension="${filename##*.}"
        if [ $extension = 'org' ]
        then
            tangle_run_export $1
        else
            echo "The script needs an org file to run."
        fi
        ;;
esac
