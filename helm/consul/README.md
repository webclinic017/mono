## Notes

Create a gossip encryption key with the following:
```
$ kubectl create secret generic consul-gossip-encryption-key --from-literal=key=$(kubectl exec consul-server-0 -- consul keygen)
```

Get a UI login token:
```
$ kubectl get secrets/consul-bootstrap-acl-token --template='{{.data.token | base64decode }}'
```
