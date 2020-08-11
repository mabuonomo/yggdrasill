k8s_dev_start:
	minikube start --base-image=gcr.io/k8s-minikube/kicbase:v0.0.10
	kubectl config current-context minikube

k8s_kompose_create:
	rm -R k8s/* || true
	# kompose convert -c -o k8s
	kompose convert -o k8s

k8s_kompose_publish:
	kubectl cluster-info
	kompose up --push-image=false --server=https://172.17.0.2:8443 || true
	kubectl apply -f k8s/here-node-deployment.yaml 
	kubectl get deployment,svc,pods,pvc
	# up sembra non faccia anche apply dei deployment

k8s_kompose_down:
	kubectl cluster-info
	kompose down #--server=https://172.17.0.2:8443 #https://github.com/kubernetes/kompose/issues/125

k8s_kompose_restart:
	kubectl cluster-info
	kompose restart #--server=https://172.17.0.2:8443 #https://github.com/kubernetes/kompose/issues/125

k8s_kustomize_init:
	kustomize ./k8s/

k8s_kustomize_build_dev:
	kustomize build ./k8s/dev

# principal, build and publish docker and k8s
k8s_kustomize_apply_dev:
	git add .
	git commit -m "Publish docker"
	make k8s_build_docker
	cd ./k8s/dev && kustomize edit set image "registry.gitlab.com/vivus1/andromeda-here:$$(git rev-parse HEAD)"
	kustomize build ./k8s/dev
	kustomize build ./k8s/dev | kubectl apply -f -

k8s_build_docker:
	docker build -t "registry.gitlab.com/vivus1/andromeda-here:latest" -t "registry.gitlab.com/vivus1/andromeda-here:$$(git rev-parse HEAD)" . -f ./cancer-docker/node/Dockerfile.microservices.prod
	docker push registry.gitlab.com/vivus1/andromeda-here:$$(git rev-parse HEAD)
	docker push registry.gitlab.com/vivus1/andromeda-here:latest
	# docker run --name nodongdo -p 50051:50051 node-microservices //test	