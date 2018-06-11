username=`git config --global github.user`
if [ "$username" = "" ]; then
    echo "Could not find username, run 'git config --global github.user <username>'"
    invalid_credentials=1
fi
echo $username
# get repo name
dir_name=`basename $(pwd)`
read -p "Do you want to use '$dir_name' as a repo name?(y/n)" answer_dirname
case $answer_dirname in
  y)
    # use currently dir name as a repo name
    reponame=$dir_name
    ;;
  n)
    read -p "Enter your new repository name: " reponame
    if [ "$reponame" = "" ]; then
        reponame=$dir_name
    fi
    ;;
  *)
    ;;
esac


echo "Creating Github repository '$reponame' ..."
curl -u $username https://api.github.com/user/repos -d '{"name":$reponame}'
echo " done."
touch README.md
echo " done."

# push to remote repo
echo "Pushing to remote ..."
git init
git add -A
git commit -m "first commit"
git remote rm origin
git remote add origin https://github.com/$username/try2.git
git push -u origin master
echo " done."

# open in a browser
read -p "Do you want to open the new repo page in browser?(y/n): " answer_browser

case $answer_browser in
  y)
    echo "Opening in a browser ..."
    open https://github.com/poojz/sample
    ;;
  n)
    ;;
  *)
    ;;
esac