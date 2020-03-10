#!/opt/iexpress/python/bin/python
#/usr/bin/env python2.7
import ConfigParser
import os
import sys
import subprocess
import re
import time

def main():
    #print("ConfigFile="+sys.argv[1])
    config=openConfig(sys.argv[1])
    daemonRegistry = readDaemonsRegitry(config.get('main','DaemonsRegistry'))
    checkDaemonsRegisterStatus(config.get('main','DaemonsPid'),daemonRegistry)
    checkDaemonsPidAlive(config.get('main','DaemonsPid'),daemonRegistry,config.get('main','AppDir'))
    checkDaemonsLock(daemonRegistry)


def openConfig(file):
    try:
        config=ConfigParser.SafeConfigParser()
        if os.path.exists(file):
            config.read(file)
            return config
        else:
            raise IOError("Config file not present")
    except IOError as e:
        print("Config file not present")
        print(configFile)

def readDaemonsRegitry(registryFile):
    registry=openConfig(registryFile)
    daemons=dict()

    for daemon in registry.sections():
        daemons[registry.get(daemon,'name')] = Daemon(
        registry.get(daemon,'name'),
        registry.get(daemon,'path'),
        registry.get(daemon,'conf'),
        registry.get(daemon,'logfile'),
        registry.get(daemon,'args'),
        registry.get(daemon,'enabled'))

    return daemons


def checkDaemonsRegisterStatus(pidFile, registry):
    pids=openConfig(pidFile)

    for daemon_name, daemon in registry.items():
        if daemon_name not in pids.sections():
            pids.add_section(daemon_name)
            pids.set(daemon_name,"pid","")
            with open(pidFile, 'w') as configfile:
                pids.write(configfile)
            print("Registered new Daemon: "+daemon_name)


def checkDaemonsPidAlive(pidFile, registry, appdir):
    pids=openConfig(pidFile)
    for daemon_name, daemon in registry.items():
        # if pids.get(daemon_name,"pid") != '':
        try:
            os.kill(int(pids.get(daemon_name,"pid")) if pids.get(daemon_name,"pid") != '' else 9999999 ,0)
            print(daemon_name+" -> Alive")
        except OSError:
            #print("Daemon not alive")
            print(daemon_name+" -> Dead")
            pids.set(daemon_name,"pid",str(startDaemon(daemon,appdir))) #  
            with open(pidFile, 'w') as configfile:
                pids.write(configfile)


def startDaemon(daemon, appdir):
    os.system('{}/bin/bg.ksh {} {} {} {} >> {} 2>&1'.format(appdir ,daemon.getName(),daemon.getPath(),daemon.getConf(),daemon.getArgs(),daemon.getLogFile()))
    time.sleep(1)
    pFile=open('/tmp/{}.pid'.format(daemon.getName()),'r')
    pid = re.search('PID:(\d+)',pFile.read()).group(1)
    pFile.close()
    os.remove('/tmp/{}.pid'.format(daemon.getName()))
    return pid
    #return subprocess.Popen('nohup {} {} {} &'.format(daemon.getPath(),daemon.getConf(),daemon.getArgs()),universal_newlines=True,shell=True,stdout=open(daemon.getLogFile(),'w+'),stderr=subprocess.STDOUT, preexec_fn=os.setpgrp).pid

def checkDaemonsLock(registry):
    pass


class Daemon(object):
    """docstring for Daemon."""

    def __init__(self, name, path, conf, logfile, args, enabled):
        super(Daemon, self).__init__()
        self.name = name
        self.path = path
        self.conf = conf
        self.logfile = logfile
        self.args = args
        self.enabled = True if enabled=="True" else False

    def getName(self):
        return self.name

    def getPath(self):
        return self.path

    def getConf(self):
        return self.conf

    def getLogFile(self):
        return self.logfile

    def getArgs(self):
        return self.args

    def isEnabled(self):
        return self.enabled


    def setName(self,name):
        self.name = name

    def setPath(self,path):
        self.path = path

    def setConf(self,conf):
        self.conf = conf

    def setLogFile(self,logfile):
        self.logfile = logfile

    def setArgs(self,args):
        self.args = args

    def setEnabled(self,status):
        self.enabled = status


if __name__=="__main__":
    main()
