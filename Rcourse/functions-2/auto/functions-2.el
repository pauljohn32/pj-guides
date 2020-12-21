(TeX-add-style-hook "functions-2"
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
     "Sweavesize"
     "Rcolor"
     "Rbackground")
    (TeX-run-style-hooks
     "pgfpages"
     "wasysym"
     "booktabs"
     "dcolumn"
     "Sweavel"
     "graphicx"
     "url"
     "listings"
     "inputenc"
     "utf8"
     "fontenc"
     "T1"
     "lmodern"
     ""
     "latex2e"
     "beamer10"
     "beamer"
     "english"
     "10pt")))

