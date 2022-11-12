#!/bin/bash
#wget -qO- https://www.ynetnews.com/category/3082 | grep -Eo "https://www.ynetnews.com/article/[a-zA-Z0-9]*" | sort -u | uniq -u > links.txt
list=$(wget -qO- https://www.ynetnews.com/category/3082 | grep -Eo "https://www.ynetnews.com/article/[a-zA-Z0-9]*" | sort -u | uniq -u)
#$list | cat links.txt
#$list > links.txt
#echo "$list"
#z=`"$list" | wc -l`
list_arr=($list)
links_num=${#list_arr[@]}
#list+=$'\n'"$z"
results="$links_num"
#read $list
#$list | sort -r
#sed -i "1i $z" links.txt
#echo $"$list" | wc -l
#echo $z
#echo "$list"

for link in $list; do
	#curr_link=$(wget -qO- $link)
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
