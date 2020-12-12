PACKAGE="KU-thesis"

mkdir -p ${PACKAGE}.gitex/${PACKAGE}

cd ${PACKAGE}
git ls-files . | tar cT - | tar -x -C "../${PACKAGE}.gitex/${PACKAGE}"
cd ..

cd ${PACKAGE}.gitex

DATE=`date +%Y%m%d`

zip -9 -r ../${PACKAGE}-${DATE}.zip ${PACKAGE}

cd ..

rm -rf ${PACKAGE}.gitex
