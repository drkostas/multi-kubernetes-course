# How to Host Kubernetes on Google Cloud
## Setup
1. Create all the Dockerfiles needed
1. Create all the .yaml configuration files for Kubernetes under `k8s`
1. Create the .travis.yml configuration for Travis
1. Create a Github repo and connect it to Travis


## Connect GC and Travis
1. Go to Google Cloud and go to IAM
1. Create a service account and a secret key
1. Download it and name it service-account.json

### Create locally a ruby image with volumes
`docker run -it -v ${pwd}:/app/travis ruby:2.3 sh`
`cd app/travis`

### Install and login to Travis
`gem install travis`
`travis login` (use github)
Copy the service-acount.json into the volume

### Generate an encrypted service-account key
`travis encrypt-file service-account.json -r drkostas/multi-kubernetes-course`
Copy the encrypted key into the root of your git repo and DELETE the unencrypted one


## Set PGPASSWORD in Google cloud using `Secret`
### Open `activate cloud shell` in GC dashboard and run:
`gcloud config set project multi-k8s-233222`
`gcloud config set compute/zone us-central1-a`
`gcloud container clusters get-credentials multi-cluster`
`kubectl create secret generic pgpassword --from-literal PGPASSWORD= a password`


## Install and run Helm
### Install it
`curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh`
`chmod 700 get_helm.sh`
`./get_helm.sh`

### Create a service account called tiller in the kube-system namespace
`kubectl create serviceaccount --namespace kube-system tiller`

### Create a new clusterrolebinding with the role 'cluster-admin' and assign it to tiller
`kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller`

### Init helm
`helm init --service-account tiller --upgrade`

### Install nginx-ingress using heml/tiller
`helm install stable/nginx-ingress --name my-nginx --set rbac.create=true`


## Setup Https
### Install heml cert-manager
`helm install --name cert-manager --namespace kube-system --version v0.4.1 stable/cert-manager`
Create an issuer.yaml and a certificate.yaml under k8s


## Finished
Push your latest changes and visit the ip that show up next to the ingress-nginx controller under Services in Google Cloud

