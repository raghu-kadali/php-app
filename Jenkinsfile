pipeline {
    agent any

    environment {
        PROJECT_ID = "raghu2pm"
        REGION     = "us-central1"
        REPO       = "php-app-repo"
        IMAGE_NAME = "php-app"
        TAG        = "latest"
    }

    stages {

        stage('Checkout PHP Code') {
            steps {
                echo "Pulling code from GitHub..."
                git 'https://github.com/yourusername/yourrepo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image for PHP + Apache..."
                sh """
                cd application
                docker build -t ${IMAGE_NAME}:${TAG} .
                """
            }
        }

        stage('Tag Docker Image for GAR') {
            steps {
                echo "Tagging image for Artifact Registry..."
                sh """
                docker tag ${IMAGE_NAME}:${TAG} \
                ${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO}/${IMAGE_NAME}:${TAG}
                """
            }
        }

        stage('Push Image to GAR') {
            steps {
                echo "Authenticating Docker with GAR..."
                sh """
                gcloud auth configure-docker ${REGION}-docker.pkg.dev -q
                """

                echo "Pushing image to Artifact Registry..."
                sh """
                docker push ${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPO}/${IMAGE_NAME}:${TAG}
                """
            }
        }

        stage('Deploy Infrastructure using Terraform') {
            steps {
                echo "Deploying MIG + ALB using Terraform..."
                sh """
                cd terraform
                terraform init
                terraform apply -auto-approve
                """
            }
        }
    }

    post {
        success {
            echo "🎉 CI/CD Pipeline Completed Successfully!"
        }
        failure {
            echo "❌ Pipeline Failed! Check logs."
        }
    }
}
