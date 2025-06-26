#!/bin/bash

function getSum {
  awk -vOFMT=%.10g '{sum += $1; square += $1^2} END {print sqrt(square / NR - (sum/NR)^2)" "sum/NR" "NR}'
}

models=$(cat target_2_10/model_judgment/ollama-llama3-3-70b_single.jsonl \
	| jq -r '[.model, .score] | @csv' \
	| awk -F',' '{print $1}' \
	| sort \
	| uniq)

folder=target_2_1	
for model in $models
do
	echo -n $model" "
	cat $folder/model_judgment/ollama-llama3-3-70b_single.jsonl \
		| jq -r '[.model, .score] | @csv' \
		| grep $model \
		| awk -F',' '{print $2}' \
		| getSum
done | sort -k 3 -n

echo
echo

for model in $models
do
	echo -n "$model "
	for folder in target_2_1 target_2_10 target_5_20 target_5_40
	do	
		cat $folder/model_judgment/ollama-llama3-3-70b_single.jsonl \
		| jq -r '[.model, .score] | @csv' \
		| grep $model \
		| awk -F',' '{print $2}' \
		| getSum
	done | awk '{print $2}' | getSum | awk '{print $1/$2}'
done
