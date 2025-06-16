#!/bin/bash

function getSum {
  awk -vOFMT=%.10g '{sum += $1; square += $1^2} END {print sqrt(square / NR - (sum/NR)^2)" "sum/NR" "NR}'
}

for model in "ollama-llama3-3-70b" "ollama-codestral-22b" "ollama-deepseek-coder-33b" "ollama-deepseek-r1-70b" "ollama-starcoder2-15b" 
do
	echo "Parallel ResponseTimemean ResponseTimestddev TTFTmean TTFTstddev TPSmean TPSstddev" > $model.csv
	for parallelity in 1 5 10 20
        do
        	echo -n "$parallelity "
        	cat parallel_"$parallelity"_"$model".csv | awk '{print $2}' | getSum | awk '{print $2" "$1}' | tr "\n" " "
        	cat parallel_"$parallelity"_"$model".csv | awk '{print $3}' | getSum | awk '{print $2" "$1}' | tr "\n" " "
        	cat parallel_"$parallelity"_"$model".csv | awk '{print $4}' | getSum | awk '{print $2" "$1}'
        done >> $model.csv
done
