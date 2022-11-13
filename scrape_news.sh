#!/bin/bash
list=$(wget -qO- https://www.ynetnews.com/category/3082 | grep -Eo "https://www.ynetnews.com/article/[a-zA-Z0-9]*" | sort -u | uniq -u)
list_arr=($list)
links_num=${#list_arr[@]}
results="$links_num"

for link in $list; do
	ben_gvir=$(wget -qO- $link | grep -o 'Ben-Gvir' | wc -l)
	netanyahu=$(wget -qO- $link | grep -o 'Netanyahu' | wc -l)
	gantz=$(wget -qO- $link | grep -o 'Gantz' | wc -l)
	lapid=$(wget -qO- $link | grep -o 'Lapid' | wc -l)
	if (( $ben_gvir==0 )) && (( $netanyahu==0 )) && (( $gantz==0 )) && (( $lapid==0 )); then
		res=$(echo "$link", -)
	else
		res=$(echo "$link", Netanyahu, $netanyahu, Gantz, $gantz, Lapid, $lapid, Ben-Gvir, $ben_gvir)
	fi

	results+=$'\n'"$res"

done

echo "$results" > results.csv
