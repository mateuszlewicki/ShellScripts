#!/usr/bin/python2.7
import time, os
while True:
    os.write(1,"work\n")
    time.sleep(60)
