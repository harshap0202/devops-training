pipeline {
    agent any

    stages {
        stage ('Checkout') {
            steps {
                git url: 'https://github.com/harshap0202/sample-java-docker.git', credentialsId: 'personal-git', branch: 'test'
            }
        }

        stage ('Java Application') {
            steps {
                script {
                    echo "Java Application Output"
                    sh 'javac App.java'
                    sh 'java App.java'
                }
            }
        }

        stage ('Docker Build') {
            steps {
                script {
                    docker.withRegistry('', registryCredential){
                        def customImage = docker.build("harshpatil02/myjava-app:${env.BUILD_ID}")
                        customImage.push()
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {

                script {
                    docker.withRegistry('', registryCredential) {
                        def runContainer = docker.image("santoshpagire/myjava-app:${env.BUILD_ID}").run('--name mynew-container -d')
                        echo "Container ID: ${runContainer.id}"
                    }
                }
            }
        }

        stage('Output') {
            steps{
                script{
                    sh 'java App.java'
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