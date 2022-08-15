#!/bin/bash

for instance in controller-0 controller-1 controller-2; do
  external_ip=$(aws ec2 describe-instances --filters \
    "Name=tag:Name,Values=${instance}" \
    "Name=instance-state-name,Values=running" \
    --output text --query 'Reservations[].Instances[].PublicIpAddress')
  
  scp -i ${1}/workspace/${2}/${2}_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null encryption-config.yaml ubuntu@${external_ip}:~/
done