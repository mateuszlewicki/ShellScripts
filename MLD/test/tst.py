import subprocess, os, signal
#os.spawnl(os.P_NOWAIT, 'dummy.py')
#os.fork()
#proc = subprocess.Popen(['./run.sh', './dummy.py'],
 #                    cwd="/home/mlewicki/Projects/scripts/MLD/test/",
  #                   stdout=subprocess.PIPE,
   #                  stderr=subprocess.STDOUT)
def preexec_function():
    signal.signal(signal.SIGINT, signal.SIG_IGN)
pp = subprocess.Popen(['nohup ./dummy.py','&'],shell=True,close_fds=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE, preexec_fn=os.setpgrp).pid
#p=os.system('nohup ./dummy.py &')
print(pp)
