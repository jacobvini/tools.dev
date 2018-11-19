# Thumb Rules:
# Build order matters.

#go for build
declare -a modules=(
    "versioning" 
    "reverse-engineering"
    "core-domain"
    "core-rest"
    "core-jdbc"
    "config"
    "gateway"
    "enterprise"
    "settings"
    "identity"
)

declare -A results

pushd ..

for module in "${modules[@]}"
do
        pushd ${module}
        mvn clean install
	if [ "$?" -eq 0 ]; 
		then results[${module}]="SUCCESS"; 
		else results[${module}]="FAILURE"; break; 
	fi
        popd
done

popd

printf '=%.0s' {1..70}
printf "\n%-50s | %-20s\n" "MODULE" "RESULT"
printf '=%.0s' {1..70}
printf '\n'
for module in "${modules[@]}"
do
	printf "%-50s | %-20s\n" "$module" "${results[$module]}"
done
printf '=%.0s' {1..70}
printf '\n'
