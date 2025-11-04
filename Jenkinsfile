pipeline {
    agent any

    tools{
        maven 'MavenTool'
        jdk 'OpenJdk17'
    }

    environment {
        SNAP_REPO = 'vprofile-snapshot'
        NEXUS_USER = 'admin'
        NEXUS_PASS = 'admin'
        RELEASE_REPO = 'vprofile-release'
        CENTRAL_REPO = 'vpro-maven-central'
        NEXUS_GRP_REPO = 'vprofile-group'
        NEXUSIP = '172.31.41.246'
        NEXUSPORT = '8081'
        NEXUSLOGIN = 'Nexus_Credentials'
    }

    stages{

        stage('Job Starting') {
            steps{
                echo 'Jenkins Job Started'
            }
        }
        stage('Build Applications') {
            steps {
                sh 'mvn -s settings.xml -DskipTests install'
            }
        }
    }


}