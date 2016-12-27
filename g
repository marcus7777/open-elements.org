mkdir gitRepos

for T in `bower cache list --allow-root | sort | grep -o -P "(?<=\=).*(?=#)" | uniq -u`
do
  cd gitRepos
    git clone ${T}
  cd ..
done 

cd gitRepos
for D in `ls`
do
  cd ${D} && \
    mkdir ../../dist/bower_components/${D}/ -p && \
    cat .git/config | grep "url = " > ../../dist/bower_components/${D}/giturl && \
    git rev-list --all --header > ../../dist/bower_components/${D}/gitlog && \
  cd ..
done 
