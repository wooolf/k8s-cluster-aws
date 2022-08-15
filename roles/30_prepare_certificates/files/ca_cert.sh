#!/bin/bash

CA_LIST=(ca-key.pem ca.pem)

count=0

for e in ${CA_LIST[@]}
do
  if test -f ${e}
  then
    echo "CA cert ${e} are already there!"
    echo "Delete them first to continue."
    exit 1
  fi
done

cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF

cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "PL",
      "L": "Poland",
      "O": "Kubernetes",
      "OU": "CA",
      "ST": "WLKP"
    }
  ]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca