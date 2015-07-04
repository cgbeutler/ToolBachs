#!/bin/bash
# Helper function
array_contains () {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == $seeking ]]; then
            in=0
            break
        fi
    done
    return $in
}

norp_operations=( setup )
rp_operations=( push pull )

# Check if the .qsync file is in this folder
if [ ! -r .qsync ]; then
	# Check if we have just 1 argument or an invalid argument
	if [ "$#" -ne 1 ] || ! array_contains norp_operations $1; then
		echo "No .qsync in this directory" >&2
		echo "Usage: qsync.sh setup" >&2
		exit 1
	else
		echo "Setting up .qsync"

		# Create the .qsync file
		cat > .qsync << END_TEXT
#========== Targets ==========
# Target variable names list
#   Example: targets=( home_rpm work_rpm )
targets=( sample_target )

# Target variables
#   Examples:
#   home_rpm="~/rpm/"
#   work_rpm="steve@work_hostname:~/rpm/"
sample_target="username@hostname:file/path"

#========== Excludes ==========
# Shell array of files to exclude with --exclude=filepattern
# Example: excludes=( .git Makefile.local )
excludes=(
.qsync
)
END_TEXT
		time1=`stat -c%y .qsync`
		vim .qsync
		time2=`stat -c%y .qsync`
		if [ "$time1" == "$time2" ]; then
			echo ".qsync file unchanged. Setup aborted."
			rm .qsync
			exit 1
		fi
		echo "Setup seccessful"
	fi
	exit
fi

source .qsync

# Check for a target given on the command line
if [ "$#" -ne 2 ]; then
	echo "Usage: qsync.sh [pull|push] [target]" >&2
	echo -n "  targets: "
	printf '%s ' "${targets[@]}"
	echo ''
	exit 1
fi

# Check that the operation is in the list
if ! array_contains rp_operations $1; then
	echo "Error: Unrecognized operation $1"
	echo "Operations available:"
	printf '%s\n' "${rp_operations[@]}"
	exit 1
fi

# Check that the target is in the list of targets
if ! array_contains targets $2; then
	echo "Error: Unrecognized target $2"
	echo "Targets available:"
	printf '%s\n' "${targets[@]}"
	exit 1
fi

# ======= Run rsync =======
# Prepend the '--exclude= tag' to each exclude
excludes=( "${excludes[@]/#/--exclude=}" )

# Evaluate the target name to get the variable
set -f
eval target=\$$2
set +f

# Here we go! Lets move that stuff!
case $1 in
	pull)
		rsync -ravh "${excludes[@]}" "${target}" .
		;;
	push)
		rsync -ravh "${excludes[@]}" . "${target}"
		;;
esac
# =========================
