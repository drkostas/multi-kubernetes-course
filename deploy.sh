docker build -t drkostas/multi-client:latest -t drkostas/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t drkostas/multi-server:latest -t drkostas/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t drkostas/multi-worker:latest -t drkostas/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push drkostas/multi-client:latest
docker push drkostas/multi-server:latest
docker push drkostas/multi-worker:latest

docker push drkostas/multi-client:$SHA
docker push drkostas/multi-server:$SHA
docker push drkostas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=drkostas/multi-server:$SHA
kubectl set image deployments/client-deployment client=drkostas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=drkostas/multi-worker:$SHA