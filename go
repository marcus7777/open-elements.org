ls bower_components/*/*.html > app/list-of-elements &&\
rm dist/ -rf && mkdir dist &&\
cp bower_components/ dist/bower_components/ -r &&\
for D in `ls -d bower_components/*-*`
do
  cp -nv bower_components/polymer/index.html dist/${D}/index.html
done

cp app/* dist/ -r &&\
rsync -a ./dist/ root@bikefix.co.uk:/var/www/html/open-elements.org/
firebase deploy 
