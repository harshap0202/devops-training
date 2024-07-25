pipeline {
    agent any
    tools {
        maven 'Maven-3.9.0'
    }
    stages {
        stage ('Checkout') {
            steps {
                git url: 'https://github.com/harshap0202/new-maven-project.git', credentialsId: 'personal-git', branch: env.GIT_BRANCH
            }
        }
        stage ('Build') {
            steps {
                script {
                    echo "Building Branch -> ${env.GIT_BRANCH}"
                    sh 'mvn clean package'
                }
            }
        }
        stage ('Test') {
            steps {
                script {
                    echo "Testing Branch -> ${env.GIT_BRANCH}"
                    sh 'mvn test'
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline Finished'
        }
        success {
            echo 'Status : Successfull'
        }
        failure {
            echo 'Status : Failed'
        }
    }
}