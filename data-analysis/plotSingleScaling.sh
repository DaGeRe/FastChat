
for targetRequests in 2 5 10
do
	for parallel in 1 10 20 40
	do
		cat target_"$targetRequests"_"$parallel"/parallel_"$parallel"_ollama-llama3-3-70b_"$targetRequests".csv \
			| awk '{sum += $5; sum2 += $6; count++; if (count == 5) { print $3" "sum / 5" "sum2/5; sum = 0; sum2=0; count = 0; } }' \
			> plottable_"$parallel".csv
	done
	./plotSingleScaling.plt
	mv singleScaling.pdf singleScaling_targetRequests"$targetRequests".pdf
done
