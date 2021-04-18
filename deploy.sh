docker build -t reildoc33/multi-client-k8s:latest -t reildoc33/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t reildoc33/multi-server-k8s-pgfix:latest -t reildoc33/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t reildoc33/multi-worker-k8s:latest -t reildoc33/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push reildoc33/multi-client-k8s:latest
docker push reildoc33/multi-server-k8s-pgfix:latest
docker push reildoc33/multi-worker-k8s:latest

docker push reildoc33/multi-client-k8s:$SHA
docker push reildoc33/multi-server-k8s-pgfix:$SHA
docker push reildoc33/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=reildoc33/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=reildoc33/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=reildoc33/multi-worker-k8s:$SHA