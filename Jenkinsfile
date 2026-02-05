pipeline {
    // Agent we will use any Agent Node in the Jenkins to run this pipeline
    agent {
        any  
    }

    tools {
        // Mention the Tool configured in the Jenkins Server like Java, Maven, Git 
        maven 'Maven_Tool'
        jdk 'Java_Tool'
    }

    // Set Environment Variable for the Nexus to interact to download the dependencies and upload artifacts in the Nexus
    environment {

        NEXUS_USER = 'admin'
        NEXUS_PASS = 'admin'
        RELEASE_REPO = 'vprofile-release'
        CENTRAL_REPO = 'vprofile-maven-central'
        SNAP_REPO = 'vprofile-snapshot'
        NEXUS_GRP_REPO = 'vprofile-maven-group'
        NEXUSIP = '172.31.32.231'
        NEXUSPORT = '8081'
        NEXUS_LOGIN = 'NEXUS_CREDENTIALS'

    }

    stages {
        stage ('Build Applications') {
            steps {
                sh 'mvn -s settings.xml DskipTests install' // Run Install and use setting.xml file and skip unit test
            }
        }
    }
}