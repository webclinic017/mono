kubectl create secret tls ca-tls \
    --cert=tools/bash/ca.pem \
    --key=tools/bash/ca-key.pem \
    --namespace vault

kubectl create secret tls vault-tls \
    --cert=tools/bash/vault.pem \
    --key=tools/bash/vault-key.pem \
    --namespace vault
