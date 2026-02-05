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

## Github SSH Issue

When your running jenkins Job for the First Time, Jenkins will use SSH Key to authenticate to Github to pull the code.

- Switch to the Jenkins User `sudo su - jenkins `
- Run COmmand `ssh -T git@github.com `

---

## Github Webhook

- When we commit a code in the main branch in the repos then jenkins should trigger the Job Automatically. So we need to use Webhook in Git

- Add Public Ip address of Jenkins /github-webhook/

- In real time, we will use EIP or Load Balancer

- In Job we need to ensure trigger is enabled in the jenkins job configuration 

- Add Stage for the Application for Maven test and check style

- In Build Stage add a Post section to save the war file in the artifacts

---

## Code Analysis and Sonar Qube

- Run the Jenkins File and Target Folder will be created in this folder all war file, checkstyle report will be present. 

- We need to upload this report to the Sonar Qube Server to check it 

- In Tools add SonarQube Scanner  and select the version

- In Jenkins System, Add the Sonar Qube Server URL (Private Key) and Token (Create a Credentials to store the Token)

- In SonarQube, Create a Token (Administration -> Token)

- Write a Code in the Pipeline (Refer Documentation)