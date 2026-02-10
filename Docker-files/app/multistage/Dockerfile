#This is a base image of Maven
FROM maven:3.9.9-eclipse-temurin-21-jammy AS build_image 

# Cloning the Java Application code from the repository
RUN git clone https://github.com/hkhcoder/vprofile-project.git

# Checkout Docker Branch from repos and run mvn install to build the war file 
RUN cd vprofile-project && git checkout docker && mvn install


# This is a distroless Image 
FROM tomcat:10-jdk21

# Remove default web apps running in the tomcat server
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the war file or binary from the base image and use in this image and upload in the default file location of the tomcat server
COPY --from=build_image vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Expose the Port and run the tomcat server "Cataline.sh"
EXPOSE 8080
CMD ["catalina.sh", "run"]
