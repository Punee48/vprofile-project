# Prerequisites
#
8484848
- JDK 17 or 21
- Maven 3.9
- MySQL 8

# Technologies 
- Spring MVC
- Spring Security
- Spring Data JPA
- Maven
- JSP
- Tomcat
- MySQL
- Memcached
- Rabbitmq
- ElasticSearch
# Database
Here,we used Mysql DB 
sql dump file:
- /src/main/resources/db_backup.sql
- db_backup.sql file is a mysql dump file.we have to import this dump to mysql db server
- > mysql -u <user_name> -p accounts < db_backup.sql


---

## Jenkins Configuartion

* We need to install Plugin for Docker, AWS and add credentials of the IAM User to connect to AWS

  - Docker Pipeline 
  - CloudBees Docker Build and Publish
  - ECR
  - AWS Pipeline 

* Add Credentials of the IAM User --> KIND: AWS Cred -> Paste the Access Key and Secret Access Key

* Login to the Jenkins Server 

* Install aws cli in the server 

* Install Docker Engine in the Server 

*  Test if the docker is running

* Provide Docker permission to Jenkins User by adding jenkins to the docker group 

---


## Docker Build in Pipeline

Build Docker Image for the Application and upload to the ECR

- Start All Instance and run the trigger the Job

- Write a Docker file for App

- Write a Stage to Upload the Docker image to the ECR

- Create a Variable to store AWS Account, registryCredentials, AppRegistry, vprofileRegistry

- Write two stage for Build the Docker Image and Upload the App Image

- Create a new pipeline and mention the Git Information to use the JenkinsFile

---

## AWS ECS Setup

We will host the Application conatiner using Docker Image in the Elastic Container Service

- Open AWS -> ECS Service

- Create a CLuster
  * AWS Fargate 
  * Monitoring : Container Insight
  * Submit
  * Create a Task Defination
  * Select OS, CPU, Memory
  * Container and paste the url of the ECR Image
  * Mention Port 8080
  * In Cluster Create a Service for AutoScaling, Deployment 
  * Create SG for HTTP, 8080
  * Enable Load Balancer

---

## Pipeline for ECS

- Ensure Cluster Service is up and running

- In Pipeline save the variable of the cluster and service

- Create a new stage 


---

## Promote to Prod

In Previous Steps we have deployed the docker image to the Cluster where testing team will perform testing for the application. Once it is approved by them and gave signal to deploy in Prod. We need to create a new cluster in ecs


- Use the same Task Definition where we have configure the docker image with port 

- In Cluster create a service and attach the task definition, Set ASG, SG PORT 80,8080 (AnyWhere)

- Create a new jenkins pipeline for the Production

- Create a new Branch for Production. 

- Remove Testing Stage in the Jenkins File and add only deploy stage 

- Create a new Pipeline and configure the git branch, URL and Credentials 

---

## Resource Limits

- In a Cluster every node will have a set of CPU and Memory assigned to the Node. When a Pod need to be created in the Node. Some CPU and Memory will be assigned to the Pod to run the containers. 

- Pods will be created in the Node until there is no space for a new pod to be created. Then Kube Schedule to create a pod in another node. 

- `Kube Schedule` will check for the CPU and Memory of the Node before pod to be created. 

- `Resource Request`: In the Pod YAML File, we can mention the resource of the pod that require cpu and memory to run the conatiner. Based on that Kube Scheduler will assign the node for the pod which has resources in it 

```yaml
apiVersion: # Version of the K8s APU server
kind: # Type of Object like Service, Pod, Service, Deployment
metadata:   # Metadata information used to add label to the pods
  name: myapp-pod
  labels:
    app: myapp
    type: front-end
spec:     #
  containers:
    - name: nginx-controller
      image: nginx
  resources:
    requests: 
      memory: "4gi"
      cpu: 2 
```

- `Resource Limit`: We can also set the limit for the pod that need to be used and inform not to use above then this limit for the pod in the Node. 

Example: If we mention limit for 4 CPU. Pod running in the Node will not use CPU more than 4 it will stck to 4 CPU only.

```yaml
apiVersion: # Version of the K8s APU server
kind: # Type of Object like Service, Pod, Service, Deployment
metadata:   # Metadata information used to add label to the pods
  name: myapp-pod
  labels:
    app: myapp
    type: front-end
spec:     #
  containers:
    - name: nginx-controller
      image: nginx
  resources:
    requests: 
      memory: "4gi"
      cpu: 2 
    limits:
      memory: "6gi"
      cpu: 3
```

- When our pods use more memory then the limits. Our pod will be terminated due to error `OOM` "Out Of Memory"

- We can write a YAML File for the Limit Range that the pod or container need to be used in the Node. 

```yaml
apiVersion: v1
kind: LimitRange
metadate: 
  name: cpu-resource-contraints
spec:
  - default:
      cpu: 500m
    defaultRequest: 
      cpu: 500m
    max:
      cpu: "1"
    min:
      cpu: 100m
    type: container
```

- For node, we can set the resource quota means Node should a only this much cpu and memory 

```yaml
apiVersion: v1
kind: ResourceQuota
metadata: 
  - name: my-resource-quota
spec: 
  hard:
    requests.cpu: 4
    requests.memory: 4Gi
    limits.cpu: 10
    limits.memory: 10Gi

```

```yaml
# 1. Delete the rabbit Pod.
kubectl delete pod rabbit

# 2. Another pod named elephant has been deployed in the default namespace but is failing to reach a running state.

# Inspect this pod using the command kubectl describe and identify the Last State Reason that explains why the container continues to crash.

kubectl get pods
kubectl get pod elephant 

# 3. The status OOMKilled indicates that it is failing because the pod ran out of memory. Identify the memory limit set on the POD.

kubectl describe pod elepant # My running this command we can find the limits set to the pods 

# 4. The elephant pod runs a process that consumes 10Mi of memory. Increase the limit of the elephant pod to 20Mi.


# Delete and recreate the pod if required. Do not modify anything other than the required fields.


kubectl get pod elephant -o yaml > elephant.yaml

# Edit the Memory in the limit field 

kubectl delete pod elephant 
kubectl create -f elephant.yaml # Create a pod

kubectl replace -f elephant --force # this command will delete the existing pod and run the new yaml file of the pods 
```

---

## DaemonSets

Daemon Set is similar to replicaset. It will ensure one copy of the pod is running in every nodes in the cluster 

- If a new node is added. A pod will be created automatically in the node. 

- If a node deleted. Pod will be deleted. 

- This Pod will also be available in the Nodes. 

- This Pod can be used for Monitoring Agents in the Node, Networking, Logs Collections

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: log-agent
spec:
  selector:
    matchLabels:
      app: log-agent
  template:
    metadata:
      labels:
        app: log-agent
    spec:
      containers:
      - name: fluentd
        image: fluentd:latest

```

### Practise of Deamon Sets

```yaml

# How many DaemonSets are created in the cluster in all namespaces?

# Check all namespaces

kubectl get daemonsets --all-namespaces

# 2. On how many nodes are the pods scheduled by the DaemonSet kube-proxy?

1 

# Help to find the image name of the Daemon Set 
 kubectl describe pod kube-flannel-ds-bkkzk -n kube-flannel 

# 6 Deploy a DaemonSet for FluentD Logging.

# Use the given specifications.
# Name: elasticsearch
# Namespace: kube-system
# Image: registry.k8s.io/fluentd-elasticsearch:1.20

kubectl create deployment elasticsearch --image=registry.k8s.io/fluentd-elasticsearch:1.20 -n kube-system --dry-run=client -o yaml > fluentD.yml

# Create Deployment File and then edit it has a daemonset file 

apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: elasticsearch
  name: elasticsearch
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: elasticsearch
  template:
    metadata:
      labels:
        app: elasticsearch
    spec:
      containers:
      - image: registry.k8s.io/fluentd-elasticsearch:1.20
        name: fluentd-elasticsearch
        resources: {}
status: {}


# Run the Daemonset
```
---

## Static Pods

In our Cluster, If we don't have a master node with component Api server, etcd, Scheduler. 

We have only Worker Node and Kubelet installed in it. 

If need to create a pod without Apiserver and Kube Scheduler, We need to create pod definition Yaml file and paste in the Directory in the Worker node. 

- Kubelet will read the directory and pod definition and create a pod. If we make any changes in the pod definition inside the directory kubelet will run the new pod delete the old one

- Also maintain the Pod Lifecycle. If a pod is terminated then a new pod is created in the worker node

This pod is called a `Static Pod` which is created by kubelet witout api server and kubeschedulers

For viewing the pod run command `docker ps`

- `USecase`: Help to deploy a control plane component as a static pods 


---

## Practise of Static Code

```yaml
# 1. How many static pods exist in this cluster in all namespaces?

# Static Pod Name ends with the name of the nodes 
kubectl get pods --all-namespaces

# Command used to check the Image used for the static pod

kubectl describe pod kube-apiserver-controlplane -n kube-system





```
