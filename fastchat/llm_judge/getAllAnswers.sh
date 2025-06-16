for model in "ollama-llama3-3-70b" "ollama-codestral-22b" "ollama-deepseek-coder-33b" "ollama-deepseek-r1-70b" "ollama-starcoder2-15b" "vllm-bigcode-starcoder2-15b" "vllm-deepseek-coder-33b-instruct-2gpus" "vllm-deepseek-r1-distill-llama-70b-4gpus" "vllm-mistralai-codestral-22b-v0-1-2gpus"
do
	echo "== Getting answers for model $model == "
	python gen_api_answer.py --model $model --openai-api-base https://kiara.sc.uni-leipzig.de/api --parallel 10
	echo
	echo
done

