bower prune 
echo "pruned bower"

sh g
echo "git local"
ls bower_components/*/*-*.html > dist/list-of-elements
echo "make list of elements"


echo "make list of"
grep \"_source\":\  bower_components/*/.bower.json | grep git:\/\/[^\"]*-[^\"]*[^\"]* -o > dist/gitList
echo "  _source"
grep \"_release\":\[^,]*  bower_components/*/.bower.json -o >> dist/gitList
echo "  _release"
ls bower_components/*/bower.json >> dist/gitList
echo "  bower.json"
ls bower_components/*/.travis.yml >> dist/gitList
echo "  .travis.yml"
ls bower_components/*/wct.conf.json >> dist/gitList
echo "  wct.conf.json"


echo "coping in to dist bower_components and gitRepos"
rsync -a bower_components/ dist/bower_components/ && rsync -a gitRepos/ dist/bower_components/
echo "copied"

#for E in `ls bower_components/*-* -d`
#do
  #pcregrep -M "(?=<template>)(\n|.)*(?=<\/template>)" ${E}/*-*.html > dist/${E}/.tpl.html
#done

for T in `grep ga.js dist/*/*/* | grep ^[^:]* -o`
do
  rm ${T} -f
done 
echo "deleted files with ga.js"

rsync bower.json dist/bower.json
for D in `ls -d bower_components/*-*`
do
  cp -n bower_components/polymer/index.html dist/${D}/index.html
done
echo "copied polymers doc gen index in to all elements with out a index"

grep rel=\"import\".*\"../[^\"]*  bower_components/*-*/*-*.html -o > dist/imports

ls -d bower_components/*/test/ > dist/tests
echo "make list of tests"

rsync -a app/* dist/
echo "add app"

echo uploading
rsync -a ./dist/ root@bikefix.co.uk:/var/www/html/open-elements.org/
echo inSync
