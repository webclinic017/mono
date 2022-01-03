#!/usr/bin/env bash

cfssl gencert -initca tools/bash/ca-csr.json | cfssljson -bare tools/bash/ca

cfssl gencert \
    -ca=tools/bash/ca.pem \
    -ca-key=tools/bash/ca-key.pem \
    -config=tools/bash/ca-config.json \
    -profile=default \
    tools/bash/vault-csr.json | cfssljson -bare tools/bash/vault
