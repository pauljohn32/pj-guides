(TeX-add-style-hook "data-1"
 (lambda ()
    (LaTeX-add-environments
     "topcolumns")
    (TeX-add-symbols
     '("vn" 1)
     "vb"
     "vh"
     "vf"
     "splus"
     "R"
     "makebeamertitle"
     "Rcolor"
     "Rbackground"
     "Sweavesize")
    (TeX-run-style-hooks
     "pgfpages"
     "wasysym"
     "booktabs"
     "dcolumn"
     "Sweavel"
     "graphicx"
     "url"
     "listings"
     "textcomp"
     "xcolor"
     "inputenc"
     "utf8"
     "fontenc"
     "T1"
     "lmodern"
     ""
     "latex2e"
     "beamer11"
     "beamer"
     "english"
     "11pt"
     "plots/t-recode60")))

