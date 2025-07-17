#!/bin/gnuplot

set encoding iso_8859_1
set terminal pdf size 5,10

outname = sprintf("scaling_%s.pdf", model)
set out outname

set key top left

set multiplot layout 5,1

set y2tics
set y2range [0:15]

do for [parallelity in "1 10 20 50 100"] {
    filename = sprintf("plottable_%s_%s.csv", parallelity, model)
 #   print "Filename: " .filename
    currentTitle = sprintf("parallelity=%s, targetRequests=%d", parallelity, targetRequests);
    set title currentTitle
    plot filename using ($0*5):3 with linespoints title 'Pods' axis x1y2, \
         filename using ($0*5):4 with linespoints title 'Average TTFT', \
         filename using ($0*5):5 with linespoints title 'Average TPS'

}
	
unset multiplot
unset out
