FROM maven:3.9.9-eclipse-temurin-21-jammy AS BUILD_IMAGE

# Set the Working Directory Inside the COntainer
WORKDIR /app

#CLONE THE REPOS
RUN git clone https://github.com/Punee48/vprofile-project.git

# RUN CMD to Change Directory, Build the Project
RUN cd vprofile-project && git checkout container && mvn clean package 


FROM tomcat:10-jdk21

# Remove the default web apps in the Tomcat Server
RUM rm -rf /usr/local/tomcat10/webapps/*

# COPY the WAR File from the BUILD_IMAGE Stage
COPY --from=BUILD_IMAGE /app/vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Application will be available at port 8080
EXPOSE 8080

CMD ["catalina.sh", "run"]