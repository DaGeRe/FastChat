#!/bin/gnuplot

set encoding iso_8859_1
set terminal pdf size 5,3

set out "scaling.pdf"

set xlabel 'Parallel Requests'
set ylabel 'TPS'

plot "results/scaling_all.csv" using 2:4 with linespoints title 'Mistral-24b', \
         "results/scaling_all.csv" using 2:9 with linespoints title 'Meta LLama 70b', \
         "results/scaling_all.csv" using 2:14 with linespoints title 'Meta Llama 4 17b-16e'
         
unset out
