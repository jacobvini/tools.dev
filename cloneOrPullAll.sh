# Thumb Rules:
# Build order matters.

#go for build
declare -a repos=(
    "git@github.com:puffincreek/settings.git"
    "git@github.com:puffincreek/enterprise.git"
    "git@github.com:puffincreek/config.git"
    "git@github.com:puffincreek/vault.dev.git"
    "git@github.com:puffincreek/identity.git"
    "git@github.com:puffincreek/versioning.git"
    "git@github.com:puffincreek/reverse-engineering.git"
    "git@github.com:puffincreek/gateway.git"
    "git@github.com:puffincreek/core-rest.git"
    "git@github.com:puffincreek/core-domain.git"
    "git@github.com:puffincreek/core-security.git"	
)

declare -A results
pushd ..

for repo in "${repos[@]}"
do
	repoTail=${repo##*\/}
	dirName=${repoTail%.git}
	if [ -d "$dirName" ]; 
	then
  		pushd ${dirName}
		git pull
		if [ "$?" -eq 0 ];
			then results[${repo}]="SUCCESS"; 
			else results[${repo}]="FAILURE"; break; 
		fi
		popd		
	else
		git clone ${repo}
		if [ "$?" -eq 0 ];
			then results[${repo}]="SUCCESS"; 
			else results[${repo}]="FAILURE"; break; 
		fi
	fi	
done

popd

printf '=%.0s' {1..70}
printf "\n%-50s | %-20s\n" "MODULE" "RESULT"
printf '=%.0s' {1..70}
printf '\n'
for repo in "${repos[@]}"
do
	printf "%-50s | %-20s\n" "$repo" "${results[$repo]}"
done
printf '=%.0s' {1..70}
printf '\n'
