#!/usr/bin/ksh

export _LOG_DIR="${LAWDIR}/system"
export _SRC_DIR="${LAWDIR}/${XXPDL}"
export _SCR_DIR="/scripts"


alias lsof='/usr/bin/lsof'
alias rmi='rm -i'
alias source='.'
alias chenv='source cv'
alias smc='grep "()" ${_SCR_DIR}/startenv.sh ${_SCR_DIR}/stopenv.sh | cut -d "(" -f 1 | grep -v "^#" | cut -d " " -f 2| cut -d : -f 2'


source ${_SCR_DIR}/startenv.sh
source ${_SCR_DIR}/stopenv.sh

cdp() {
	cd $@
	pwd 
}
