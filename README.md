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