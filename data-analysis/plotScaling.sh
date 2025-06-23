#!/bin/bash

function getSum {
  awk -vOFMT=%.10g '{sum += $1; square += $1^2} END {print sqrt(square / NR - (sum/NR)^2)" "sum/NR" "NR}'
}


for model in ollama-llama3-3-70b ollama-codestral-22b ollama-deepseek-coder-33b ollama-deepseek-r1-70b ollama-starcoder2-15b vllm-llama-4-scout-17b-16e-instruct          vllm-meta-llama-llama-3-3-70b-instruct vllm-deepseek-coder-33b-instruct-2gpus vllm-nvidia-llama-3-3-70b-instruct-fp8 vllm-llama-3-3-nemotron-super-49b-v1
do
	for parallelity in 10 20 40
	do
		cd target_2_$parallelity
		echo -n "$model $parallelity "
		cat parallel_"$parallelity"_$model"_2".csv | awk '{print $6}' | getSum | awk '{print $2}' | tr "\n" " "
		tail -n 1 parallel_"$parallelity"_$model"_2".csv | awk '{print $3}'
		cd ..
	done
done
