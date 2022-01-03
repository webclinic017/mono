.PHONY: deepclean vault-bootstrap

deepclean: # Deep clean local docker
	docker container prune -f
	docker image prune -a -f
	docker volume prune -f

vault-bootstrap:
	./tools/bash/gencert.sh
	./tools/bash/gensecret.sh
