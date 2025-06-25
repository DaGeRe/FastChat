for targetRequests in 2 5 10
do
	echo "== Analyzing with targetRequests=$targetRequests"
	for parallelity in 40 20 10 1
	do
		resultFolder="data/target_"$targetRequests"_"$parallelity
		echo "Taking data from $resultFolder"
		cp -R $resultFolder/model_answer data/mt_bench/
		python gen_judgment.py --mode single \
			--model-list ollama-codestral-22b ollama-deepseek-coder-33b ollama-deepseek-r1-70b ollama-llama3-3-70b ollama-starcoder2-15b vllm-deepseek-coder-33b-instruct-2gpus vllm-llama-3-3-nemotron-super-49b-v1 vllm-llama-4-scout-17b-16e-instruct vllm-meta-llama-llama-3-3-70b-instruct vllm-nvidia-llama-3-3-70b-instruct-fp8 \
			--parallel 20 \
			--openai-api-base https://kiara.sc.uni-leipzig.de/api \
			--judge-model ollama-llama3-3-70b
		mv data/mt_bench/model_judgment $resultFolder
	done
done
