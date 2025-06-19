#!/bin/gnuplot

set encoding iso_8859_1
set terminal pdf size 10,6

set out 'responseTimes.pdf'

set multiplot layout 2,3

set xlabel "Parallel Requests"

set ylabel "Response Time / s"

plot 'ollama-llama3-3-70b.csv' u 1:2 w linespoint lc "red" title 'ollama-llama3-3-70b', \
	'ollama-llama3-3-70b.csv' u 1:($2-$3):($2+$3) w filledcurves lc "red" notitle fs transparent solid 0.5, \
     'ollama-codestral-22b.csv' u 1:2 w linespoint lc "blue" title 'ollama-codestral-22b', \
	'ollama-codestral-22b.csv' u 1:($2-$3):($2+$3) w filledcurves lc "blue" notitle fs transparent solid 0.5, \
     'ollama-deepseek-coder-33b.csv' u 1:2 w linespoint lc "green" title 'ollama-deepseek-coder-33b', \
	'ollama-deepseek-coder-33b.csv' u 1:($2-$3):($2+$3) w filledcurves lc "green" notitle fs transparent solid 0.5
	
set ylabel "TTFT / s"
	
plot 'ollama-llama3-3-70b.csv' u 1:4 w linespoint lc "red" title 'ollama-llama3-3-70b', \
	'ollama-llama3-3-70b.csv' u 1:($4-$5):($4+$5) w filledcurves lc "red" notitle fs transparent solid 0.5, \
     'ollama-codestral-22b.csv' u 1:4 w linespoint lc "blue" title 'ollama-codestral-22b', \
	'ollama-codestral-22b.csv' u 1:($4-$5):($4+$5) w filledcurves lc "blue" notitle fs transparent solid 0.5, \
     'ollama-deepseek-coder-33b.csv' u 1:4 w linespoint lc "green" title 'ollama-deepseek-coder-33b', \
	'ollama-deepseek-coder-33b.csv' u 1:($4-$5):($4+$5) w filledcurves lc "green" notitle fs transparent solid 0.5
	
set ylabel "TPS / Tokens/s"

plot 'ollama-llama3-3-70b.csv' u 1:6 w linespoint lc "red" title 'ollama-llama3-3-70b', \
	'ollama-llama3-3-70b.csv' u 1:($6-$7):($6+$7) w filledcurves lc "red" notitle fs transparent solid 0.5, \
     'ollama-codestral-22b.csv' u 1:6 w linespoint lc "blue" title 'ollama-codestral-22b', \
	'ollama-codestral-22b.csv' u 1:($6-$7):($6+$7) w filledcurves lc "blue" notitle fs transparent solid 0.5, \
     'ollama-deepseek-coder-33b.csv' u 1:6 w linespoint lc "green" title 'ollama-deepseek-coder-33b', \
	'ollama-deepseek-coder-33b.csv' u 1:($6-$7):($6+$7) w filledcurves lc "green" notitle fs transparent solid 0.5
	
set ylabel "Response Time / s"

plot 'ollama-deepseek-r1-70b.csv' u 1:2 w linespoint lc "orange" title 'ollama-deepseek-r1-70b', \
	'ollama-deepseek-r1-70b.csv' u 1:($2-$3):($2+$3) w filledcurves lc "orange" notitle fs transparent solid 0.5, \
     'ollama-starcoder2-15b.csv' u 1:2 w linespoint lc "blue" title 'ollama-starcoder2-15b', \
	'ollama-starcoder2-15b.csv' u 1:($2-$3):($2+$3) w filledcurves lc "blue" notitle fs transparent solid 0.5
	
set ylabel "TTFT / s"
	
plot 'ollama-deepseek-r1-70b.csv' u 1:4 w linespoint lc "orange" title 'ollama-deepseek-r1-70b', \
	'ollama-deepseek-r1-70b.csv' u 1:($4-$5):($4+$5) w filledcurves lc "orange" notitle fs transparent solid 0.5, \
     'ollama-starcoder2-15b.csv' u 1:4 w linespoint lc "blue" title 'ollama-starcoder2-15b', \
	'ollama-starcoder2-15b.csv' u 1:($4-$5):($4+$5) w filledcurves lc "blue" notitle fs transparent solid 0.5
	
set ylabel "TPS / Tokens/s"

plot 'ollama-deepseek-r1-70b.csv' u 1:6 w linespoint lc "orange" title 'ollama-deepseek-r1-70b', \
	'ollama-deepseek-r1-70b.csv' u 1:($6-$7):($6+$7) w filledcurves lc "orange" notitle fs transparent solid 0.5, \
     'ollama-starcoder2-15b.csv' u 1:6 w linespoint lc "blue" title 'ollama-starcoder2-15b', \
	'ollama-starcoder2-15b.csv' u 1:($6-$7):($6+$7) w filledcurves lc "blue" notitle fs transparent solid 0.5

unset multiplot
unset output
