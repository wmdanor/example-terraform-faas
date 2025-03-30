#!/bin/bash

usage="$0 <function-name>"

prefix=aws-lambda-
fn="${prefix}${1}"

if [ -z "$1" ]; then
echo "Usage: $usage. Missing <function-name>"
exit 1
fi

aws lambda invoke --function-name ${fn} \
    --payload '{"message": "Hello"}' \
    --cli-binary-format raw-in-base64-out \
    temp --no-cli-pager

cat temp

rm temp
