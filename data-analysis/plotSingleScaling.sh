
cat target_2_40/parallel_40_ollama-llama3-3-70b_2.csv \
	| awk '{sum += $5; sum2 += $6; count++; if (count == 5) { print $3" "sum / 5" "sum2/5; sum = 0; sum2=0; count = 0; } }' \
	> plottable.csv
	
./plotSingleScaling.plt
