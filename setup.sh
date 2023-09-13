#!/bin/bash

# Creating Kind Cluster
kind create cluster --name poc-kong --config k8s/kind.yml
kubectl cluster-info --context kind-poc-kong

# Creating Kong Namespace
kubectl create ns kong
kubectl create ns poc
helm repo add kong https://charts.konghq.com

helm install kong kong/kong -f k8s/kong/kong-conf.yml --set proxy.type=NodePort,proxy.http.nodePort=30000,proxy.tls.nodePort=30003 --set ingressController.installCRDs=false --set serviceMonitor.enabled=true --set serviceMonitor.labels.release=promstack --namespace kong

kubectl apply -f setup-jwt.yml
# # Creating POC Namespace

# # Creating API Key
# kubectl create secret generic poc-apikey --from-literal=kongCredType=key-auth --from-literal=key=supersecret -n poc # apikey=supersecret

# # Creating Service
# kubectl apply -f k8s/service.yml -n poc

# # Creating Deployment
# kubectl apply -f k8s/deployment.yml -n poc

# kubectl apply -f k8s/kong/plugins/jwt-auth.yml -n poc

# kubectl apply -f k8s/kong/consumer/jwt-consumer.yml -n poc
# kubectl apply -f k8s/kong/credentials/jwt-credentials.yml

# # Creating Ingress
# kubectl apply -f k8s/ingress.yml -n poc

# # Kong Stuff
# # Configure Kong Ingress
# # kubectl apply -f k8s/kong/ingress.yml -n poc

# # Configure Plugins
# kubectl apply -f k8s/kong/plugins/key-auth.yml -n poc
# kubectl apply -f k8s/kong/plugins/rate-limit.yml -n poc

# # Configure Consumer
# kubectl apply -f k8s/kong/consumer/poc-consumer.yml -n poc