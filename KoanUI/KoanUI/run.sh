#!/bin/sh

#  run.sh
#  CommandLine
#
#  Created by Alberto Pasca on 18/05/16.
#  Copyright © 2016 albertopasca.it. All rights reserved.

KOANPATH="/Volumes/DATA/Dropbox/Work/Personal/Koan-Swift/KoanTestcase/"
cd $KOANPATH
xctool -scheme KoanTest test -parallelize -reporter plain:/tmp/koan-tests-output.txt
