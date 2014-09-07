#!/bin/bash
for i in `seq 0 12`; do (echo $i && send_osc 12000 /signal $i) && read ;done
