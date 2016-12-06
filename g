mkdir gitRepos


for D in `ls bower_components -r`
do
  for T in `bower cache list | sort | grep -o -P "(?<=\=).*(?=#)" | uniq -u`
  do
    cd gitRepos
    git clone ${T} && (
      cd ${D}
        bower register ${D} ${T} -f --allow-root
      cd .. ) && git add . && git commit -am "auto add bower"
    cd ..
  done 
done


for D in `ls bower_components/`
do
  cd gitRepos/${D}/ && \
  git rev-list --all --header > ../../dist/bower_components/${D}/gitlog && \
  cd ../..
done 
