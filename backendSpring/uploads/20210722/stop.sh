#!/bin/sh
kill $(ps aux | grep 'dma.jar' | awk '{print $2}') >/dev/null 2>&1 &
echo "dma server stop."