## Build Docker Image for Tomcat and XWiki
docker build . -t registry.devops.senia.org/k8s/images/tomcat-xwiki:12.10.11.2

docker push registry.devops.senia.org/k8s/images/tomcat-xwiki:12.10.11.2

## Create ConfigMap Entries from xwiki xml config files
kubectl  create configmap tomcat-xwiki-context --from-file=context.xml=context.xml.clean

kubectl  create configmap tomcat-xwiki-hibernate --from-file=hibernate.cfg.xml=hibernate.cfg.xml.clean

kubectl apply -f xwiki_configmap.yaml

## Deploy the xwiki_statefulset
kubectl apply -f xwiki_statefulset.yaml 

### Note: Using Local Registries with Docker Images:
kubectl create secret docker-registry registry-devops-senia \

--docker-server=registry.devops.senia.org \

--docker-username=k8simages \ 

--docker-password=passwordGoesHere \ 

--namespace=default 
