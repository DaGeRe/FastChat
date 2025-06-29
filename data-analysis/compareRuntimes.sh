#!/bin/bash

function getSum {
  awk -vOFMT=%.10g '{sum += $1; square += $1^2} END {print sqrt(square / NR - (sum/NR)^2)" "sum/NR" "NR}'
}

export targetRequests=10

for model in vllm-meta-llama-llama-3-3-70b-instruct ollama-llama3-3-70b
do
	echo "#Model TTFT TPS" > $model.csv
	for parallel in 1 10 20 40
	do
		echo -n "$parallel "
		cat target_"$targetRequests"_"$parallel"/parallel_"$parallel"_"$model"_"$targetRequests".csv \
			| awk '{print $5}' | getSum | awk '{print $2}' | tr "\n" " "
		cat target_"$targetRequests"_"$parallel"/parallel_"$parallel"_"$model"_"$targetRequests".csv \
			| awk '{print $6}' | getSum | awk '{print $2}'
	done >> $model.csv
done

gnuplot -c compareRuntimes.plt
