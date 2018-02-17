#!/usr/bin/env bash

NAME_FILTER=$1

REGIONS=( us-east-2 us-east-1 us-west-2 us-west-1 eu-west-3 eu-west-2 eu-west-1 eu-central-1 ap-northeast-2 ap-northeast-1 ap-southeast-2 ap-southeast-1 ca-central-1 ap-south-1 sa-east-1 )
for region in "${REGIONS[@]}"; do
	IMAGES=`aws ec2 describe-images --filters Name=name,Values=${NAME_FILTER} Name=virtualization-type,Values=hvm --owners amazon --region ${region}`
	AMI_TO_USE=`echo ${IMAGES} | jq .Images | jq -c 'sort_by(.CreationDate) | .[-1]'`
	IMAGE_ID=`echo ${AMI_TO_USE} | jq -r .ImageId`
	IMAGE_NAME=`echo ${AMI_TO_USE} | jq -r .Name`

	echo "$region:"
	echo "    AMI: ${IMAGE_ID} # ${IMAGE_NAME}"
done
