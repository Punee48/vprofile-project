FROM tomcat:10-jdk21
LABEL "Project"="Vprofile"
LABEL "Author"="Puneeth Kumar"

#Remove exiting webapps
RUN rm -rf /usr/local/tomcat/webapps/*

#After building the Java application will upload the war file to the web apps of the tomcat server 
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME /usr/local/tomcat/webapps