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
            // Once Build is Successful Archive the Artifact .war file
            post{
                success {
                    echo(message: 'Build Successful, Archiving the Artifacts')
                    archiveArtifacts artifacts: '**/*.war'
                }
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
                    sh '''${SONARSCANNER_HOME}/bin/sonar-scanner -Dsonar.projectKey=vprofile \
                    -Dsonar.projectName=VProfile_Test \
                    -Dsonar.projectVersion=1.0 \
                    -Dsonar.sources=src/ \
                    -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                    -Dsonar.jacoco.reportPaths=target/jacoco.exec \
                    -Dsonar.junit.reportPaths=target/surefire-reports/ \
                    -Dsonar.java.checkstyle.reportPaths=target/checkstyle-results.xml'''
                }
            }
        }

        // #Write a new stage for testing the quality gates
        stage("Quality Gate") {
            steps {
                timeout(time: 1, unit: 'MINUTES') {
                    waitForQualityGate(abortPipeline: true)
                }
            }
        }
        stage("Deploy the Artifact to Nexus Repos") {
            steps {
                nexusArtifactUploader(
                    nexusVersion: 'nexus3'
                    protocol: 'http',
                    nexusUrl: "${NEXUSIP}:${NEXUSPORT}",
                    repository: "${RELEASE_REPO}"
                    credentialsId: "${NEXUSLOGIN}",
                    groupId: 'QA'
                    version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}"
                    artifacts: [
                        [
                            artifactId: 'vprofileapp',
                            classifier: '',
                            file: 'target/vprofile-v2.war',
                            type: 'war'
                        ]
                    ]
                )
            }
        }
    }


}