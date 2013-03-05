for file in *; do
    if [ -d $file ]; then
        cd $file
        echo $file; 
        if [ -d .git ]; then
        echo 'git'
            git pull
      fi
      if [ -d .svn ]; then
        echo 'svn'
        svn update
      fi
      cd ..
   fi
done
vim -c "call pathogen#helptags()" -c "q"

