#!/bin/bash

for targetRequests in 2 5 10
do
	echo "== Analyzing with targetRequests=$targetRequests"
	for parallelity in 40 20 10 1
	do
		for model in ollama-llama3-3-70b vllm-deepseek-coder-33b-instruct vllm-deepseek-r1-distill-llama-70b vllm-llama-3-3-nemotron-super-49b-v1 vllm-llama-4-scout-17b-16e-instruct vllm-meta-llama-llama-3-3-70b-instruct vllm-mistral-small-24b-instruct-2501 vllm-nvidia-llama-3-3-70b-instruct-fp8
		do
			kubectl patch model $model --type merge -p '{"spec": {"targetRequests": '$targetRequests'}}'
			echo "== Getting answers for model $model $parallelity == "
			python gen_api_answer.py --model $model --openai-api-base https://kiara.sc.uni-leipzig.de/api --parallel $parallelity
			mv data/responseTime.csv data/parallel_$parallelity"_"$model"_"$targetRequests.csv
			echo "Resetting replicas"
                        kubectl patch model $model --type merge -p '{"spec": {"maxReplicas": 1}}'
                        sleep 30s
                        kubectl patch model $model --type merge -p '{"spec": {"maxReplicas": 64}}'

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

