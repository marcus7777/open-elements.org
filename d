rm dist/ -rf && mkdir dist &&\
bower prune &&\

ls bower_components/*/*-*.html > dist/list-of-elements
cat dist/list-of-elements | grep sweet

grep \"_source\":\  bower_components/*/.bower.json | grep git:\/\/[^\"]*-[^\"]*[^\"]* -o > dist/gitList
grep \"_release\":\[^,]*  bower_components/*/.bower.json -o >> dist/gitList

cp bower_components/ dist/bower_components/ -r

for T in `grep ga.js dist/*/*/* | grep ^[^:]* -o`
do
  rm ${T} -f
done 

cp bower.json dist/bower.json -r 
for D in `ls -d bower_components/*-*`
do
  cp -n bower_components/polymer/index.html dist/${D}/index.html
done

grep rel=\"import\".*\"../[^\"]*  bower_components/*-*/*-*.html -o > dist/imports

ls -d bower_components/*/test/ > dist/tests

cp app/* dist/ -r &&\
echo uploading
rsync -a ./dist/ root@bikefix.co.uk:/var/www/html/open-elements.org/ --size-only
echo up
rsync -a ./dist/ root@bikefix.co.uk:/var/www/html/open-elements.org/
echo inSync
