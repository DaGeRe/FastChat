set encoding iso_8859_1
set terminal pdf size 5,3

set out 'llama_comparison.pdf'

set key top center

set xlabel 'Parallel Requests'
set ylabel 'TTFT / s'
set y2label 'TPS / Requests / s'

plot 'llama_comparison.csv' u 1:3 w linespoint title 'Ollama TTFT', \
	'llama_comparison.csv' u 1:9 w linespoint title 'vLLM TTFT', \
	'llama_comparison.csv' u 1:6 w linespoint title 'Ollama TPS' axis x1y2, \
	'llama_comparison.csv' u 1:12 w linespoint title 'vLLM TPS' axis x1y2
	
unset multiplot
unset out
