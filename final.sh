creditcard()
{
     
		rev=$i
		sd=0
		or=$i
		n=1
		 osum=0
		 esum=0
		while [ $n -le ${#rev} ]
		do
		a=`echo $rev | cut -c $n`
		c=$(( $a * 2))
		if [[ $c -gt 9 ]]
		then
		   add=$c
		   s=0
		 
		# use while loop to
		# caclulate the sum
		# of all digits
		while [ $add -gt 0 ]
		do
			# get Remainder
			k=$(( $add % 10 )) 
		 
			# get next digit
			 add=$(( $add / 10 ))
		 
			# calculate sum of
			# digit  
			s=$(( $s + $k ))
			
		done
			c=$s
		fi
		e=$(( $n + 1))
		b=`echo $rev | cut -c $e`
		d=$b
		n=$(( $n + 2))
		#echo "the odd digits $c"
		#echo "the even digits $d"

		#echo "$s is the number"
		osum=$((osum + d))
		esum=$((esum + c))

		done
		ans=$((esum + osum))
		#echo $ans
		mod=$(($ans % 10))
		# echo $mod
}



scan()
{
    # echo "hi"
	# echo "enter the url of the repository"
	# read url
	# url_without_suffix="${url%.*}"
	# reponame="$(basename "${url_without_suffix}")"
	 b="/*"
	c="$p$b"
	 #echo $c
	 
	for file in `pwd`/*; do
	    flag1="B"
	flag2="B"
		echo $(basename "$file")
		f="(password|pass|server_password)([^/]+)"
		ser="servername([^/]+)"	
		for i in `cat $file`
		do
			m=$i
			
			if  [[ $m =~ $f ]]
			then
			 flag1="A"
		#		echo $m
			fi	
			if  [[ $m =~ $ser ]]
			then
			 flag2="A"
		#	 echo $m
			fi	
			if  [[ $flag1 == "A" && $flag2 == "A" ]]
			then
			 # echo $m
				echo -e "\e[00;31mPASSWORD FOUND!\e[00m in \e[\033[01;33m$(basename "$file")\e[00m "
				echo "enter the folder name to move your files"
				read $moved
				mv $file ~/Desktop/$moved/
				
			break
			fi	
			re='^[0-9]+$'
if [[ $i =~ $re ]] ; then
 echo $i
mod=$( creditcard )
echo $mod
if  [[ "$mod" -eq "0" ]]
			then
				
				echo -e "\e[00;31mCREDITCARD NUMBER FOUND\e[00m in \e[\033[01;33m$(basename "$file")\e[00m "
				echo "enter the folder name to move your files"
				read $moved
				mv $file ~/Desktop/$moved/
			break
			fi	
   
fi
reg="^-----BEGIN RSA PRIVATE KEY-----$"
#|^-----BEGIN OPENSSH PRIVATE KEY-----.*$|^-----BEGIN CERTIFICATE-----$|^-----BEGIN DSA PRIVATE KEY-----.*$|^-----BEGIN EC PRIVATE KEY-----.*$|^-----BEGIN PGP PRIVATE KEY BLOCK-----.*$)"
if  [[ $i =~ $reg ]]
			then
				
				echo -e "\e[00;31mPRIVATE KEY FOUND!\e[00m in \e[\033[01;33m$(basename "$file")\e[00m "
				echo "enter the folder name to move your files"
				read $moved
				mv $file ~/Desktop/$moved/
				
			break
			fi	
awskey="^AKIA[0-9A-Z]{16}"
#[a|A][w|W][s|S].*AKIA[0-9A-Z]{16}$"
			if  [[ $m =~ $awskey ]]
			then
				echo -e "\e[00;31mAWSKEY FOUND!\e[00m in \e[\033[01;33m$(basename "$file")\e[00m "
				echo "enter the folder name to move your files"
				read $moved
				mv $file ~/Desktop/$moved/
				
			break
			fi	
			
			
	done 
	done
	
	
}
upload()
{
			username=`git config github.user`
		if [ "$username" = "" ]; then
			echo "Could not find username, run 'git config --global github.user <username>'"
			invalid_credentials=1
		fi

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


		# create repo
		# echo "Creating Github repository '$reponame' ..."
		# curl -u $username https://api.github.com/user/repos -d '{"name":"'$reponame'"}'
		# echo " done."

		# create empty README.md
		echo "Creating README ..."
		touch README.md
		echo " done."

		# push to remote repo
		echo "Pushing to remote ..."
		git init
		git add -A
		git commit -m "first commit"
		git remote rm origin
		git remote add origin https://github.com/$username/$reponame.git
		git push -u origin master
		echo " done."
}

echo "enter the folder name"
read p
cd "$p" && scan
#t= "password=345"
upload