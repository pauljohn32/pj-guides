The full file set can be retrieved by "cloning it".  

If you are not expecting to become a contributor, the easiest
way to download a set is to clone this repository using HTTP protocol

```git clone  https://gitlab.crmda.ku.edu/crmda/posters.git```

If you might become a contributor, it will be necessary
to register an account for yourself in our GitLab server
(see instructions http://crmda.ku.edu/git-help).

Please enable LFS on your computer before cloning (generally
as simple as installing the lfs component and running git install lfs).
See: CRMDA git LFS note: http://crmda.dept.ku.edu/guides/31.git/31.git-lfs.md
and maybe the documentation with gitlab,  https://gitlab.crmda.ku.edu/help/workflow/lfs/manage_large_binaries_with_git_lfs but the part of this you need to worry about is just running


```git lfs install```

to enable your user account to integrate git and LFS.  On our lab
computers, we do that on an administrative level, system-wide,
but your computer probably needs to have this done within your user
account. After that, run

```git clone git@gitlab.crmda.ku.edu:crmda/posters.git```

