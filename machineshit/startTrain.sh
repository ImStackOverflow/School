#! /bin/bash

#update python path
export PYTHONPATH=$PYTHONPATH:~/.local/lib/python3.5/site-packages/tensorflow/models/research:~/.local/lib/python3.5/site-packages/tensorflow/models/research/slim

#echo $PYTHONPATH

#pipeline file
PIPELINE=/home/gchen/.local/lib/python3.5/site-packages/tensorflow/models/waldo/waldo.config
#PIPELINE=/home/gchen/GitShit/School/machineshit/trained_model/example.config

#training directory path
TRAIN=/home/gchen/GitShit/School/machineshit/model


#EXECUTE!
python train.py --logtostderr --pipeline_config_path=$PIPELINE --train_dir=$TRAIN