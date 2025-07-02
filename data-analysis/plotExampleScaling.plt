#!/bin/gnuplot

set encoding iso_8859_1
set terminal pdf size 5,3

set out 'exampleScaling.pdf'

set y2tics
set y2range [0:15]

filename = "plottable_20.csv"
plot filename using ($0*5):1 with linespoints title 'Pods' axis x1y2, \
         filename using ($0*5):2 with linespoints title 'Average TTFT', \
         filename using ($0*5):3 with linespoints title 'Average TPS'

unset out
