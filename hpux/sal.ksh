#!/usr/bin/ksh

export _LOG_DIR="${LAWDIR}/system"
export _SRC_DIR="${LAWDIR}/${XXPDL}"
export _SCR_DIR="/lawtrans/a699323/scripts"


alias lsof='/usr/bin/lsof'
alias rmi='rm -i'
alias source='.'
alias chenv='source cv'
alias smc='grep "()" ${_SCR_DIR}/{start,stop}env.sh | cut -d "(" -f 1 | grep -v "^#" | cut -d " " -f 2'


source ${_SCR_DIR}/startenv.sh
source ${_SCR_DIR}/stopenv.sh

cdp() {
	cd $@
	pwd 
}

#  base 	/1024					/1024^2
# df . | perl -ple 's!(\d\d\d+)!($1/1024)!ge' | perl -ple 's!(\d\d\d+)!($1/1024)!ge' 
# echo -ne "\033]0;testing\007" # test if putty tile changes
