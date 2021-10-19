docker build -t jorgejsilva/multi-client:latest -t jorgejsilva/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jorgejsilva/multi-server:latest -t jorgejsilva/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jorgejsilva/multi-worker:latest -t jorgejsilva/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jorgejsilva/multi-client:latest
docker push jorgejsilva/multi-server:latest
docker push jorgejsilva/multi-worker:latest

docker push jorgejsilva/multi-client:$SHA
docker push jorgejsilva/multi-server:$SHA
docker push jorgejsilva/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jorgejsilva/multi-server:$SHA
kubectl set image deployments/client-deployment client=jorgejsilva/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jorgejsilva/multi-worker:$SHA