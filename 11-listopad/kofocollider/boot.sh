#!/bin/bash
pkill scsynth
(sleep 3s && (rm /tmp/lang; mkfifo /tmp/lang)) &
(sleep 5s && tail -f /tmp/lang | sclang) &
(xterm -e "scsynth -u 57110")
#(sleep 7s && echo -E '(s.boot;s = Server.new("remote" , NetAddr("127.0.0.1",  57110 ) );s.options.initialNodeID = 1000;s.queryAllNodes;s.initTree;f = {Group.new(s.defaultGroup)};ServerTree.add(f);s.sendBundle(["/g_dumpTree", 0, 0]);s.queryAllNodes;Server.local = s;Server.default = s; Server.internal = s;s.sendBundle(0.1,["sync",1]);s.sendBundle(0.2,["notify",1]);)' > /tmp/lang)

