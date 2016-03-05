rsync -a gitRepos/ dist/bower_components/
echo uploading
rsync -a ./dist/ root@bikefix.co.uk:/var/www/html/open-elements.org/
echo inSync
