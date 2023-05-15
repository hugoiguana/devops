install-cluster:
	@echo "Creation cluster"	
	kind create cluster --config kind.yml --name helm-clamav-antivirus
	kubectl config use-context kind-helm-clamav-antivirus

install-apps:	
	@echo "Installing helm charts"
	helm repo add wiremind https://wiremind.github.io/wiremind-helm-charts
	kubectl create namespace clamav
	##helm dependency build ./clamav-antivirus-chart
	helm install clamav-antivirus-chart ./clamav-antivirus-chart -n clamav

upgrade-apps:	
	helm upgrade clamav-antivirus-chart ./clamav-antivirus-chart -n clamav

uninstall-apps:
	kubectl delete namespace clamav

uninstall-cluster:
	kind delete cluster --name kind-helm-clamav-antivirus

