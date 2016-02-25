ls bower_components/*/*.html > app/list-of-elements &&\
rm dist/ -rf && mkdir dist &&\
cp bower_components/ dist/bower_components/ -r &&\
cp bower.json dist/bower.json -r &&\
for D in `ls -d bower_components/*-*`
do
  cp -n bower_components/polymer/index.html dist/${D}/index.html
done

pcregrep -M '"dependencies":[^\}]*' bower.json | grep '": "' > dist/bowerList
for D in `ls -d bower_components/*-*/bower.json`
do
  pcregrep -M '"dependencies":[^\}]*' ${D} | grep '": "'  >> dist/bowerList 
done

ls -d bower_components/*/test/ > dist/tests

cp app/* dist/ -r &&\
rsync -a ./dist/ root@bikefix.co.uk:/var/www/html/open-elements.org/
firebase deploy 
