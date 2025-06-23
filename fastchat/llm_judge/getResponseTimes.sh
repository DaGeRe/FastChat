#!/bin/bash

for targetRequests in 2 5 10
do
	echo "== Analyzing with targetRequests=$targetRequests"
	for parallelity in 40 20 10 1
	do
		for model in ollama-codestral-22b ollama-deepseek-coder-33b ollama-deepseek-r1-70b ollama-llama3-3-70b ollama-starcoder2-15b vllm-deepseek-coder-33b-instruct-2gpus vllm-llama-3-3-nemotron-super-49b-v1 vllm-llama-4-scout-17b-16e-instruct vllm-meta-llama-llama-3-3-70b-instruct vllm-nvidia-llama-3-3-70b-instruct-fp8 vllm-systran-faster-whisper-medium-en
		do
			kubectl patch model $model --type merge -p '{"spec": {"targetRequests": '$targetRequests'}}'
			echo "== Getting answers for model $model $parallelity == "
			python gen_api_answer.py --model $model --openai-api-base https://kiara.sc.uni-leipzig.de/api --parallel $parallelity
			mv data/responseTime.csv data/parallel_$parallelity"_"$model"_"$targetRequests.csv
			echo
			echo
		done
		resultFolder="data/target_"$targetRequests"_"$parallelity
		echo "Moving everything to $resultFolder"
		mkdir $resultFolder
		mv data/*csv $resultFolder
		mv data/mt_bench/model_answer/ $resultFolder
		mkdir data/mt_bench/model_answer/
	done
done

