#!/bin/bash

function getSum {
  awk -vOFMT=%.10g '{sum += $1; square += $1^2} END {print sqrt(square / NR - (sum/NR)^2)" "sum/NR" "NR}'
}

models=$(cat target_2_10/model_judgment/vllm-llama-4-scout-17b-16e-instruct_single.jsonl \
	| jq -r '[.model, .score] | @csv' \
	| awk -F',' '{print $1}' \
	| sort \
	| tr -d "\"" \
	| uniq)

echo "Model & MeanScore & StandardDeviation"
folder=target_2_1	
for model in $models
do
	for targetRequests in 2 5 10
	do
		for parallelity in 40 20 10 1
		do
			echo -n "$model $targetRequests $parallelity "
			file=target_"$targetRequests"_"$parallelity"/parallel_"$parallelity"_$model"_"$targetRequests.csv
			cat $file | awk '{print $5}' | getSum | awk '{printf "%.3f ", $2}'
			cat $file | awk '{print $6}' | getSum | awk '{printf "%.3f", $2}'
			echo
		done
	done
done
