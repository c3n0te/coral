#!/bin/sh

ls /home

edgetpu_compiler -s -o /home/data/ /home/data/model.tflite
python3 /home/data/run.py
