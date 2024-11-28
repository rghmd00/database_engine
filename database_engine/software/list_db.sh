#!/bin/bash
cd ../schemas




if [ -z "$(ls -A )" ]; then
    echo "There are no available databases "
else
    echo "Available databases ..."
    ls -F | grep / | tr '/' ' '
fi


cd - >/dev/null
