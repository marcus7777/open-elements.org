mkdir gitRepos
for T in `grep \"_source\":\  bower_components/*/.bower.json | grep git:\/\/[^\"]*-[^\"]*[^\"]* -o`
do
  cd gitRepos
  git clone ${T}
  cd ..
done 

for D in `ls bower_components/`
do
  cd gitRepos/${D}/ && \
  git rev-list --all --header > ../../dist/bower_components/${D}/gitlog && \
  cd ../..
done 
