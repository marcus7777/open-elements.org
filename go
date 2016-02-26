rm dist/ -rf && mkdir dist &&\
ls bower_components/*/*-*.html > dist/list-of-elements &&\
cp bower_components/ dist/bower_components/ -r &&\

for T in `grep ga.js dist/*/*/* | grep ^[^:]* -o`
do
  rm ${T} -f
done 

cp bower.json dist/bower.json -r &&\
for D in `ls -d bower_components/*-*`
do
  cp -n bower_components/polymer/index.html dist/${D}/index.html
done

pcregrep -M '"dependencies":[^\}]*' bower.json | grep '": "' > dist/bowerList
for D in `ls -d bower_components/*-*/bower.json`
do
  pcregrep -M '"dependencies":[^\}]*' ${D} | grep '": "'  >> dist/bowerListUnsorted 
done

cat dist/bowerListUnsorted | tr -s [:space:] | sort -u --ignore-case --ignore-nonprinting --version-sort  > dist/bowerList

rm dist/bowerListUnsorted

grep rel=\"import\".*\"../  */*/*-*.html > dist/imports

ls -d bower_components/*/test/ > dist/tests

cp app/* dist/ -r &&\
rsync -a ./dist/ root@bikefix.co.uk:/var/www/html/open-elements.org/
firebase deploy 
