(TeX-add-style-hook "tidbits"
 (lambda ()
    (TeX-add-symbols
     '("vn" 1)
     "vb"
     "vh"
     "vf"
     "splus"
     "R"
     "makebeamertitle"
     "lyxframeend"
     "lyxframe"
     "Sweavesize"
     "Rcolor"
     "Rbackground")
    (TeX-run-style-hooks
     "babel"
     "graphicx"
     "pgfpages"
     "wasysym"
     "booktabs"
     "dcolumn"
     "Sweavel"
     "url"
     "listings"
     "inputenc"
     "latin9"
     "fontenc"
     "T1"
     "lmodern"
     ""
     "latex2e"
     "beamer10"
     "beamer"
     "english"
     "10pt")))

