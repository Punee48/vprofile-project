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