#!/bin/sh

#PBS -S /bin/sh
#PBS -N job1_actions

#PBS -l select=16
#PBS -j oe

cd /dados/israel/app_cesup

mpiexec matlab -nodesktop -r job1_actions.m