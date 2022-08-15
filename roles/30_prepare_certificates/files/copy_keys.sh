#!/bin/bash

for i in 1 2 3; do

  internal_ip=$(nslookup k8s_n${i}.local.pl | grep Address | grep -v "#" | cut -d' ' -f2)
  scp -i ~/.ssh/k8s_nodes.rsa ca.pem worker-${i}-key.pem worker-${i}.pem wooolf@${internal_ip}:~/

done


# for instance in controller-0 controller-1 controller-2; do
#   external_ip=$(aws ec2 describe-instances --filters \
#     "Name=tag:Name,Values=${instance}" \
#     "Name=instance-state-name,Values=running" \
#     --output text --query 'Reservations[].Instances[].PublicIpAddress')

#   scp -i kubernetes.id_rsa \
#     ca.pem ca-key.pem kubernetes-key.pem kubernetes.pem \
#     service-account-key.pem service-account.pem ubuntu@${external_ip}:~/
# done