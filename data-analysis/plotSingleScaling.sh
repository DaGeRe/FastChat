#!/bin/bash

function getSum {
  awk -vOFMT=%.10g '{sum += $1; square += $1^2} END {print sqrt(square / NR - (sum/NR)^2)" "sum/NR" "NR}'
}


set -e

mkdir -p results

for model in vllm-mistral-small-24b-instruct-2501 vllm-meta-llama-llama-3-3-70b-instruct vllm-llama-4-scout-17b-16e-instruct
do
	echo $model
	mkdir -p results/$model
	for targetRequests in 5 10 20
	do
		for parallel in 100 50 20 10 1
		do
			file="target_"$targetRequests"_"$parallel"/parallel_"$parallel"_"$model"_"$targetRequests".csv"
			if [ -f $file ]
			then
				cat target_"$targetRequests"_"$parallel"/parallel_"$parallel"_"$model"_"$targetRequests".csv \
					| awk '{sum += $8; sum2 += $9; count++; if (count == 5) { print $4" "$5" "$6" "sum / 5" "sum2/5; sum = 0; sum2=0; count = 0; } }' \
					> results/plottable_"$parallel"_"$model".csv
				echo -n $targetRequests" "$parallel" "
				cat results/plottable_"$parallel"_"$model".csv | head -n 100 | awk '{print $5}' | getSum
			fi
		done
		cd results
		
		
		gnuplot -e "model='$model'" -e "targetRequests=$targetRequests" ../plotSingleScaling.plt
		mv "scaling_$model.pdf" "$model/scaling_$model"_"$targetRequests.pdf"
		cd ..
	done > results/scaling_$model.csv
done

paste -d " " results/scaling_vllm-mistral-small-24b-instruct-2501.csv results/scaling_vllm-meta-llama-llama-3-3-70b-instruct.csv results/scaling_vllm-llama-4-scout-17b-16e-instruct.csv | grep "^5 "> results/scaling_all.csv

gnuplot -c plotScalingAll.plt

exit 1

export targetRequests=10
export parallel=100

cat target_"$targetRequests"_"$parallel"/parallel_"$parallel"_vllm-llama-4-scout-17b-16e-instruct_"$targetRequests".csv \
			| awk '{sum += $5; sum2 += $6; count++; if (count == 5) { print $3" "sum / 5" "sum2/5; sum = 0; sum2=0; count = 0; } }' \
			> plottable_"$parallel".csv
./plotExampleScaling.plt

mv exampleScaling.pdf results/
