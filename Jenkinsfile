pipeline {
    // Agent we will use any Agent Node in the Jenkins to run this pipeline
    agent any

    // Set Environment Variable for the Nexus to interact to download the dependencies and upload artifacts in the Nexus
    environment {

        // NEXUS_USER = 'admin'
        // NEXUS_PASS = 'admin'
        RELEASE_REPO = 'vprofile-release'
        // CENTRAL_REPO = 'vprofile-maven-central'
        // SNAP_REPO = 'vprofile-snapshot'
        // NEXUS_GRP_REPO = 'vprofile-maven-group'
        NEXUSIP = '172.31.32.231'
        NEXUSPORT = '8081'
        NEXUS_LOGIN = 'NEXUS_CREDENTIALS'
        SONAR_SCANNER = 'sonarqubescanner'
        SONAR_SERVER_LOGIN = 'sonarserver'
        NEXUS_CRED = credentials('Nexus_Login')

    }

    stages {

        // SETUP Paarameter
        stage('Setup Paramteres') {
            steps {
                script {
                    properties([
                        parameters([
                            string(defaultValue: '', description: 'Enter the Build Number From Nexus Repos', name: 'BUILD'),
                            string(defaultValue: '', description: 'Enter the Time Stamp of the Artifacts', name: 'TIME'),
                        ])
                    ])
                }
            }
        }




        stage('Ansible Deployment in App Stagging Server') {
            steps {
                ansiblePlaybook(
                playbook: 'ansible/site.yml', // In this File we have used Import command to import the other playbooks 
                inventory: 'ansible/inventory',
                credentialsId: 'SSHKEY_APP_STAG', // Cred ID of the SSH Key used to connect to the app stagging server
                colorized: true,
                installation: 'ansible',
                disableHostKeyChecking: true, // Means Jenkins will not check for the host key verification while connecting to the server
                extraVars: 
                [
                    USER: 'admin',
                    PASS: "${NEXUS_CRED}",
                    nexusip: "${NEXUSIP}",
                    reponame: 'vprofile-release',
                    groupid: 'QA',
                    time: "${env.TIME}", // Time is the variable. Input will receive from the User 
                    
                    // Build is the variable. Input will receive from the User 
                    build: "${env.BUILD}",
                    vprofile_version: "vproapp-${env.BUILD}-${env.TIME}.war",
                    artifactId: 'vproapp'

                ]
                )               
            }  
        }
    }

    // Email Notification Of the Status of Pipeline 
    post {
        always {
            echo 'Pipeline has been completed Sending Pipeline Status through Email...'
            emailext (
                body: """<p>Jenkins Build Status: <b>${currentBuild.currentResult}</b></p>
                         <p>Job Name: ${env.JOB_NAME}</p>
                         <p>Build Number: ${env.BUILD}</p>
                         <p>Check console output at: <a href='${env.BUILD_URL}'>${env.BUILD_URL}</a></p>""",
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME} | ${env.BUILD_NUMBER}", 
                to: 'puneethkumar482000@gmail.com'
            )
        }
    }
}