#!/bin/gnuplot

set encoding iso_8859_1
set terminal pdf size 5,10

set out 'singleScaling.pdf'

set multiplot layout 4,1

set y2tics
set y2range [0:15]

do for [i in "1 10 20 40"] {
    filename = sprintf("plottable_%s.csv", i)
    set title i
    plot filename using ($0*5):1 with linespoints title 'Pods' axis x1y2, \
         filename using ($0*5):2 with linespoints title 'Average TTFT', \
         filename using ($0*5):3 with linespoints title 'Average TPS'
}
	
unset multiplot
unset out
