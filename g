mkdir gitRepos
for T in `grep \"_source\":\  bower_components/*/.bower.json | grep git:\/\/[^\"]*-[^\"]*[^\"]* -o`
do
  cd gitRepos
  git clone ${T}
  cd ..
done 
