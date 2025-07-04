#!/bin/bash

set -e

mkdir -p results

for model in ollama-llama3-3-70b vllm-deepseek-coder-33b-instruct vllm-deepseek-r1-distill-llama-70b vllm-llama-3-3-nemotron-super-49b-v1 vllm-llama-4-scout-17b-16e-instruct vllm-meta-llama-llama-3-3-70b-instruct vllm-mistral-small-24b-instruct-2501 vllm-nvidia-llama-3-3-70b-instruct-fp8
do
	for targetRequests in 2 5 10
	do
		for parallel in 1 10 20 40
		do
			cat target_"$targetRequests"_"$parallel"/parallel_"$parallel"_ollama-llama3-3-70b_"$targetRequests".csv \
				| awk '{sum += $5; sum2 += $6; count++; if (count == 5) { print $3" "sum / 5" "sum2/5; sum = 0; sum2=0; count = 0; } }' \
				> results/plottable_"$parallel"_"$model".csv
		done
		cd results
		gnuplot -e "model='$model'" ../plotSingleScaling.plt
		mv "scaling_$model.pdf" "scaling_$model"_"$targetRequests.pdf"
		cd ..
	done
done

export targetRequests=5
export parallel=20

cat target_"$targetRequests"_"$parallel"/parallel_"$parallel"_ollama-llama3-3-70b_"$targetRequests".csv \
			| awk '{sum += $5; sum2 += $6; count++; if (count == 5) { print $3" "sum / 5" "sum2/5; sum = 0; sum2=0; count = 0; } }' \
			> plottable_"$parallel".csv
./plotExampleScaling.plt

mv exampleScaling.pdf results/
