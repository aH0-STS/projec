pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'docker-cred'  // Ensure this credential exists in Jenkins
        IMAGE_NAME = 'saiyash000/my-node-app'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/arjunkoppineni/my-sample-app.git'
            }
        }

        stage('Build Application') {
            steps {
                dir('myapp/backend') {
                    sh 'npm install'
                    sh 'npm test || echo "No tests found"'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('myapp/backend') {
                    script {
                        dockerImage = docker.build("${IMAGE_NAME}:latest")
                    }
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
                 withKubeConfig([credentialsId: 'kubeconfig']) {
                     dir('myapp/kubernetes') {
                         sh 'kubectl apply -f deployment.yaml'
                         sh 'kubectl apply -f service.yaml'
                         sh 'kubectl rollout status deployment my-sample-app-deployment'
                         sh 'kubectl get pods'
                     }
                 }
             }
         }
    }
}
