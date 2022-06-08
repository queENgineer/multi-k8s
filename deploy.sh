docker build -t tgbkrkmz/multi-client:latest -t tgbkrkmz/multi-client:$SHA  -f ./client/Dockerfile ./client #unique tags for built images
docker build -t tgbkrkmz/multi-server:latest -t tgbkrkmz/multi-server:$SHA  -f ./server/Dockerfile ./server #unique tags for built images
docker build -t tgbkrkmz/multi-worker:latest -t tgbkrkmz/multi-worker:$SHA  -f ./worker/Dockerfile ./worker #unique tags for built images

docker push tgbkrkmz/multi-client:latest
docker push tgbkrkmz/multi-server:latest
docker push tgbkrkmz/multi-worker:latest

docker push tgbkrkmz/multi-client:$SHA
docker push tgbkrkmz/multi-server:$SHA
docker push tgbkrkmz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=tgbkrkmz/multi-server:$SHA
kubectl set image deployments/client-deployment client=tgbkrkmz/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tgbkrkmz/multi-worker:$SHA