#!/bin/bash -e
#
# To check your submission you should run:
#
#   $ make check-part1
#   $ make check-part2
#

LOGIN=$USER
TMP=check_submission_tmp

warning() {
    echo -e "\e[01;31mWARNING: $@\e[00m"
}

error() {
    echo -e "\e[01;31mERROR: $@\e[00m"
    echo -e "\e[00;31m"
    echo -e "Read the above output to see what went wrong, and run 'git status' or 'gitk' to see what is going on.
    
If your git repository is seriously messed up, considering cloning a fresh copy from github via 'git clone <giturl>', where <giturl> is listed at your repository page at \e[00;33mhttps://github.com/ucberkeley-cs61c/$LOGIN\e[00;31m

If you can't straighten things out, please stop by office hours or lab to talk to a TA. There are also many posts on Piazza about submitting via git and numerous other online resources."
    echo -en "\e[00m"
    exit 1
}

ok() {
    echo -e "\e[01;32mSUCCESS: $@\e[00m"
}

rm -rf "$TMP"
git clone git@github.com:ucberkeley-cs61c/$LOGIN.git "$TMP" || error "Could not clone your git repo."

cd "$TMP"
cd proj2 || error "You haven't pushed the proj2 directory to github."

if [ "$1" == "part2" ]; then
    git checkout proj2-2 || error "You haven't tagged any commit proj2-2"
	make runtest &&
	    ok "You have submitted proj2-2 correctly." ||
	    warning "Your tagged commit does not pass 'make runtest'."
else
    git checkout proj2-1 || error "You haven't tagged any commit proj2-1"
    make disasmtest &&
        ok "You have submitted proj2-1 correctly." ||
        warning "Your tagged commit does not pass 'make disasmtest'."
fi

rm -rf "$TMP"

exit 0
