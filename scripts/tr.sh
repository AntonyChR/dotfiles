source=$1

#encoded_query=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$source'))")

#resp=$(curl -s "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=es&hl=es-PE&dt=t&dt=bd&dj=1&source=input&tk=979261.979261&q=$encoded_query" \
resp=$(curl -s "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=es&hl=es-PE&dt=t&dt=bd&dj=1&source=input&tk=979261.979261" \
  --data-urlencode "q=$source" \
  -H 'accept: */*' \
  -H 'accept-language: es-ES,es;q=0.9' \
  -H 'priority: u=1, i' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors')

echo $resp | jq ".sentences[0].trans"
