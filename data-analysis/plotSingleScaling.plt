#!/bin/gnuplot

set encoding iso_8859_1
set terminal pdf size 5,3

set out 'singleScaling.pdf'

set y2tics

plot 'plottable.csv' u ($0*5):1 w linespoint title 'Pods' axis x1y2, \
	'plottable.csv' u ($0*5):2 w linespoint title 'Average TTFT', \
	'plottable.csv' u ($0*5):3 w linespoint title 'Average TPS'

unset out
