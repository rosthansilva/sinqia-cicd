JenkinsUrl=jenkins.howtodevops.local
ArgoCdUrl=argocd.howtodevops.local

    echo -e " \033[0;32m ######  INSTALANDO KUBERNETES  ######  \033[0m "
    echo ''
    echo ''

    # Instala K3S
    curl -sfL https://get.k3s.io | sh -

    # configura o kubectl
    mkdir $HOME/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
    sudo chmod 644 $HOME/.kube/config

    # Check K3S
    kubectl get pods -n kube-system

    # instala helm
    curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
    chmod u+x install-helm.sh
    ./install-helm.sh

    # Linkar helm e Tiller
    kubectl -n kube-system create serviceaccount tiller
    kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
    helm init --service-account tiller

    # Check Helm
    helm repo update
    helm search jenkins

# Inicia montagem do ambiente de CI
#cd jenkins
#echo -e "###### Buildando imagem do jenkins ######" && Sleep 2
#cd jenkins
##docker build -t jenkins-ci:1.1 .
#cd ..
#kubectl create namespace jenkins
#kubectl create namespace argocd
#kubectl apply -f ./jenkins/ -n jenkins
#kubectl apply -f ./argo/ -n argocd
#kubectl port-forward svc/argocd-server -n argocd 8084:443 &

#instalando vault via helm

#helm repo add hashicorp https://helm.releases.hashicorp.com
#helm install vault hashicorp/vault


##echo -e "\033[0;32m ArgoCd Url: \033[0m"
#echo -e "\033[0;32m https://$(hostname -I | cut -f1 -d' '):8084 \033[0m"
#echo -e "\033[0;32m Usuário  : Admin \033[0m"
#echo -e "\033[0;32m Senha :  $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) \033[0m"
#kubectl apply -f jenkins/
#sleep 30 && kubectl port-forward service/jenkins-ui-service 8080:8080 -n jenkins

#echo -e "\033[0;32m https://$(hostname -I | cut -f1 -d' '):8080 \033[0m"

#kubectl logs deployment/jenkins-master  -n jenkins

#while true; do
#    read -p "Quer Resetar Seu Ambiente ?" yn
#    case $yn in
#        [Yy]* ) ./k3s-uninstall.sh; break;;
#        [Nn]* ) exit;;
##    esac
#done
