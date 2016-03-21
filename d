echo "coping in to dist gitRepos"
rsync -a gitRepos/ dist/bower_components/ --exclude .git
echo "copied"
