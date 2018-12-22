docker build -t zolingen/multi-client:latest -t zolingen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t zolingen/multi-server:latest -t zolingen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t zolingen/multi-worker:latest -t zolingen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push zolingen/multi-client:latest
docker push zolingen/multi-server:latest
docker push zolingen/multi-worker:latest

docker push zolingen/multi-client:$SHA
docker push zolingen/multi-server:$SHA
docker push zolingen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=zolingen/multi-server:$SHA
kubectl set image deployments/client-deployment client=zolingen/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=zolingen/multi-worker:$SHA

