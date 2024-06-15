url=$1
curl \
  -X POST \
  -F "url=$url" \
  http://localhost:3000/dl
