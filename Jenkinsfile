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
        SONARQUBE_SERVER = 'SonarQube_Server'
        SONARQUBE_LOGIN = 'SonarCred'
        SONARSCANNER = 'SonarQubeScanner'
    }

    stages{

        stage('Job Start') {
            steps{
                echo 'Jenkins Job Started'
            }
        }
        stage('Build Applications') {
            steps {
                sh 'mvn -s settings.xml -DskipTests install'
            }
        }
        stage("Unit Test") {
            steps {
                sh 'mvn -s settings.xml test'
            }
        }
        stage("Code Analysis - Check Style") {
            steps {
                sh 'mvn -s settings.xml checkstyle:checkstyle'
            }
        }
        stage("Sonar Qube Analysis") {
            environment {
                SONARSCANNER_HOME = tool "${SONARSCANNER}"
            }
            steps {
                withSonarQubeEnv("${SONARQUBE_SERVER}") {
                    sh '''${SONARSCANNER_HOME}/bin/sonar-scanner -Dsonar.projectkey=vprofile \
                    -Dsonar.projectName=VProfile \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.sources=src/ \
                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                    -Dsonar.jacoco.reportPaths=target/jacoco.exec \
                    -Dsonar.junit.reportPaths=target/surfire-reports \ 
                    -Dsonar.java.checkstyle.reportPaths=target/checkstyle-results.xml'''
                }
            }
        }
    }


}