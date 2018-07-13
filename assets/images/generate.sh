#!/bin/bash
result=""
name="partie4"
pages=$(pdfinfo partie4.pdf | grep Pages | awk '{print $2}')
for i in $(seq 1 $pages); do
  echo $i;
  printf -v padded "%02d" $i
  pdftoppm "$name.pdf" "$name/image" -png -f $i -l $i
  # location=$(curl --user api:SAphUo8agT8baew6hvMMv98r1ol6jyKX --data-binary @"$name/image-$padded.png" -i https://api.tinify.com/shrink | grep Location: | awk '{print $2}')
  # location=${location%$'\r'}
  # echo $location
  # curl "$location" -o "$name/image-opt-$padded.png"
  content=$(pdftotext -f $i -l $i "$name.pdf" -)
  content_no_whitespace="$(echo -e "${content}" | tr -d '[:space:]')"
  result="$result\n![$content](/assets/images/$name/image-opt-$padded.png)"
done

echo $result
