#!/bin/bash

function getSum {
  awk -vOFMT=%.10g '{sum += $1; square += $1^2} END {print sqrt(square / NR - (sum/NR)^2)" "sum/NR" "NR}'
}

models=$(cat target_2_10/model_judgment/ollama-llama3-3-70b_single.jsonl \
	| jq -r '[.model, .score] | @csv' \
	| awk -F',' '{print $1}' \
	| tr -d "\"" \
	| sort \
	| uniq)

folder=target_2_40
for model in $models
do
	echo -n $model" "
	cat $folder/parallel_40_"$model"_2.csv | tail -n 1 | awk '{print $3}' | tr "\n" " "
	cat $folder/parallel_40_"$model"_2.csv | awk '{print $6}' | getSum | awk '{print $1" "$2}'
done | awk '{print $1" "$2" "$3" "$4*100000}' | sort -n -k 4 | awk '{print $1" "$2" "$3" "$4/100000}'
