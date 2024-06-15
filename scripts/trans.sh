#!/bin/bash

WORD=$1
TRANSLATED_WORD="$(translate $1)"

echo "$1 $TRANSLATED_WORD">>~/Documentos/learn
echo $TRANSLATED_WORD
