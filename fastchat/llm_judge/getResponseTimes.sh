for model in "ollama-llama3-3-70b" "ollama-codestral-22b" "ollama-deepseek-coder-33b" "ollama-deepseek-r1-70b" "ollama-starcoder2-15b" "vllm-bigcode-starcoder2-15b" "vllm-deepseek-coder-33b-instruct-2gpus" "vllm-deepseek-r1-distill-llama-70b-4gpus" "vllm-mistralai-codestral-22b-v0-1-2gpus"
do
	for parallelity in 1 5 10 20
	do
		echo "== Getting answers for model $model $parallelity == "
		python gen_api_answer.py --model $model --openai-api-base https://kiara.sc.uni-leipzig.de/api --parallel $parallelity
		mv data/responseTime.csv data/parallel_$parallelity"_"$model.csv
		echo
		echo
	done
done

