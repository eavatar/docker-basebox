Base image from Scratch
======================================
This is the Docker image used as the base for small containers. 
Although Bash shell is supported, Busybox is in place of many utilities to reduce footprint.
Runit is the process manager and is configured to run by default.