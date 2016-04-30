mkdir gitRepos


for D in `ls bower_components`
do
  for T in `grep \"_source\":\  bower_components/${D}/.bower.json | grep git:\/\/[^\"]* -o`
  do
    cd gitRepos
    git clone ${T}
      cd ${D}
        bower register ${D} ${T} -f
      cd ..
    cd ..
  done 
done

for D in `ls bower_components/`
do
  cd gitRepos/${D}/ && \
  git rev-list --all --header > ../../dist/bower_components/${D}/gitlog && \
  cd ../..
done 
