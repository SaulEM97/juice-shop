pipeline {
    agent { label 'worker-node' }

    environment {
        ECR_REPO = "997064792377.dkr.ecr.us-east-2.amazonaws.com/jenkins-library"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION \
                | docker login \
                  --username AWS \
                  --password-stdin $ECR_REPO
                '''
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t $ECR_REPO:$IMAGE_TAG ."
            }
        }

        stage('Push') {
            steps {
                sh "docker push $ECR_REPO:$IMAGE_TAG"
            }
        }
    }

    post {
        always {
            sh "docker system prune -f"
        }
    }
}
