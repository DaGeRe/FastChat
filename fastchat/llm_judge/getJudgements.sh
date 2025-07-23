for targetRequests in 5 10 20
do
	echo "== Analyzing with targetRequests=$targetRequests"
	for parallelity in 100 50 20 10 1
	do
		resultFolder="data/target_"$targetRequests"_"$parallelity
		echo "Taking data from $resultFolder"
		cp -R $resultFolder/model_answer data/mt_bench/
		python gen_judgment.py --mode single \
			--model-list vllm-mistral-small-24b-instruct-2501 vllm-meta-llama-llama-3-3-70b-instruct vllm-llama-4-scout-17b-16e-instruct ollama-llama3-3-70b vllm-deepseek-coder-33b-instruct vllm-deepseek-r1-distill-llama-70b vllm-llama-3-3-nemotron-super-49b-v1 vllm-nvidia-llama-3-3-70b-instruct-fp8 \
			--parallel 10 \
			--openai-api-base https://kiara.sc.uni-leipzig.de/api \
			--judge-model vllm-llama-4-scout-17b-16e-instruct
		mv data/mt_bench/model_judgment $resultFolder
	done
done
