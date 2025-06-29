set encoding iso_8859_1
set terminal pdf size 5,3

set out 'llama_comparison.pdf'

set key right center

set xlabel 'Parallel Requests'
set ylabel 'TTFT / s'
set y2label 'TPS / Requests / s'

plot 'vllm-meta-llama-llama-3-3-70b-instruct.csv' u 1:2 w linespoint title 'vLLM TTFT', \
	'ollama-llama3-3-70b.csv' u 1:2 w linespoint title 'Ollama TTFT', \
	'vllm-meta-llama-llama-3-3-70b-instruct.csv' u 1:3 w linespoint title 'vLLM TPS' axis x1y2, \
	'ollama-llama3-3-70b.csv' u 1:3 w linespoint title 'Ollama TPS' axis x1y2
	
unset multiplot
unset out
