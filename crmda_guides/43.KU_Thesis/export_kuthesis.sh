##
zip -r KU-thesis-20190401.zip -x \*.*~ KU-thesis -x \*.*~

## the git-lfs defect appears here, the actual zip are not copied
git archive HEAD --format zip --output KU-thesis-20190201.zip KU-thesis
