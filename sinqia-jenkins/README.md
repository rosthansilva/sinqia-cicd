# Kubernetes Manifests for Jenkins Deployment

## Fazer deploy do jenkins
kubectl apply -f ./sinqia-jenkins

## Após instalação do jenkins
kubectl get po -n devops-tools
--
kubectl logs Nome-do-pod -n devops-tools

## Pegar Secret

SECRET_NAME=$(kubectl get serviceaccount jenkins-admin  -o=jsonpath='{.secrets[0].name}' -n devops-tools)

## Coletar base 64 do secret

kubectl get secrets $SECRET_NAME  -o=jsonpath='{.data.token}' -n devops-tools | base64 -D
