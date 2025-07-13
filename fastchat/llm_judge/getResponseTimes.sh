#!/bin/bash

function runOneConfiguration {
	model=$1
	parallelity=$2
	targetRequests=$3

	kubectl patch model $model --type merge -p '{"spec": {"targetRequests": '$targetRequests'}}'
	if [ "$parallelity" -eq 1 ]; then
		repetitions=1
	elif [ "$parallelity" -eq 10 ]; then
		repetitions=10
	else
		repetitions=20
	fi
	echo "== Getting answers for model $model parallelity: $parallelity targetRequests: $targetRequests Repetitions: $repetitions == "
	python gen_api_answer.py \
		--model $model \
		--openai-api-base https://kiara.sc.uni-leipzig.de/api \
		--parallel $parallelity \
		--repetitions $repetitions &> answering_"$targetRequests"_"$parallelity".txt
	mv data/responseTime.csv data/parallel_$parallelity"_"$model"_"$targetRequests.csv
	echo -n "Resetting replicas, replicas before: "
	kubectl get pods --output=wide | grep $model | wc -l
	kubectl patch model $model --type merge -p '{"spec": {"maxReplicas": 1}}'
	instances=$(kubectl get pods --output=wide | grep "$model" | wc -l)
	while (( "$instances" != 1 ))
	do
		sleep 5
		instances=$(kubectl get pods --output=wide | grep "$model" | wc -l)
	done
	kubectl patch model $model --type merge -p '{"spec": {"maxReplicas": 15}}'
	echo -n "Replicas after: $instances"

	echo
	echo
}

for model in vllm-mistral-small-24b-instruct-2501 vllm-meta-llama-llama-3-3-70b-instruct vllm-llama-4-scout-17b-16e-instruct ollama-llama3-3-70b vllm-deepseek-coder-33b-instruct vllm-deepseek-r1-distill-llama-70b vllm-llama-3-3-nemotron-super-49b-v1 vllm-nvidia-llama-3-3-70b-instruct-fp8
do
	echo "== Analyzing with targetRequests=$targetRequests"
	for parallelity in 100 50 20 10 1
	do
		for targetRequests in 5 10 20
		do
			runOneConfiguration $model $parallelity $targetRequests
		done
		resultFolder="data/target_"$targetRequests"_"$parallelity
		echo "Moving everything to $resultFolder"
		mkdir -p $resultFolder
		mv data/*csv $resultFolder
		mkdir -p $resultFolder/model_answer/
		mv data/mt_bench/model_answer/* $resultFolder/model_answer/
	done
done

