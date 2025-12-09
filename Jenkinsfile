pipeline {
    agent any 

    // Mention the Tools 
    tools{
        maven 'MAVEN_TOOL'
        jdk 'JAVA_TOOL'
    }

    // Set the environment variable for Nexus to interact
    environment {
        NEXUS_USER = 'admin'
        NEXUS_PASSWORD = 'admin123'
        CENTRAL_REPO = 'vpro-maven-central'
        SNAP_REPO = 'vprofile-snapshot'
        RELEASE_REPO = 'vprofile-release'
        NEXUS_GRP_REPO = 'vprofile-maven-grp'
        NEXUSIP = '172.31.39.255'
        NEXUSPORT = '8081'
        NEXUS_LOGIN = 'NEXUS_LOGIN'
    }

    // Stages

    stages {
        stage('Build Application') {
            steps {
                sh 'mvn -s settings.xml -DskipTests install'
            }
        }
    }


}