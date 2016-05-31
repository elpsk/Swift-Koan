#!/bin/sh

#  run.sh
#  CommandLine
#
#  Created by Alberto Pasca on 18/05/16.
#  Copyright © 2016 albertopasca.it. All rights reserved.

xctool -scheme UnitTest test -parallelize -reporter plain:/tmp/koan-output.txt
