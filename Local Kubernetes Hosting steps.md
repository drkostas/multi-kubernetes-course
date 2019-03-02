# How to Host Kubernetes Locally
## Installations
### For windows use chocolatey for the installation
Install kubectl and minikube

### Run minikube (For windows first create Vswitch in hyper-v)
`minikube start --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch"`

### Check if everything is running
`kubectl cluster-info`
`minikube status`

## Setup
Create all the Dockerfiles needed
Create all the .yaml configuration files for Kubernetes under `k8s`

### Apply all the .yaml files
`kubectl apply -f k8s`

### Create secret for the pgpassword
`kubectl create secret generic pgpassword --from-literal PGPASSWORD=<a password>`

### Install ingress-nginx
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml`
`minikube addons enable ingress`



## Management
### Get the ip where kubernetes is running
`minikube ip`

### Get Info
`kubectl get pods`
`kubectl get services`
`kubectl get deployments`
`kubectl get secrets`
`kubectl get pvc`

### Open the dashboard
`minikube dashboard`

### Open shell in a container or see logs
`kubectl logs client-deployment-64d86bfdcf-98kld`
`kubectl exec -it client-deployment-64d86bfdcf-98kld sh `

### Update an image by its version
`kubectl set image deployment/client-deployment client=drkostas/multi-client:v2`