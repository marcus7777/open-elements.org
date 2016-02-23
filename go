ls bower_components/*/*.html > app/list-of-elements &&\
rm dist/ -rf && mkdir dist &&\
cp bower_components/ dist/bower_components/ -r &&\
cp app/ dist/app/ -r &&\
firebase deploy 
