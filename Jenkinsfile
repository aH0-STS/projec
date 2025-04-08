pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // Ensure this credential exists in Jenkins
        IMAGE_NAME = 'saiyash000/my-node-app'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/aH0-STS/projec.git'
            }
        }


        
        stage('Build Docker Image') {
            steps {
                
                    script {
                        dockerImage = docker.build("${IMAGE_NAME}:latest")
                    
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        dockerImage.push("latest")
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
             steps {
                 withKubeConfig([credentialsId: 'configsec']) {
                  
                         sh 'kubectl apply -f deployment.yaml'
                         sh 'kubectl apply -f service.yaml'
                         sh 'kubectl get pods'
                     
                 }
             }
         }
    }
}
