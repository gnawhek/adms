#!/bin/sh
nohup java -jar dma.jar >/dev/null 2>&1 &
echo "dma server start."