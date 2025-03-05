pipeline {
    agent any

    environment {
        TF_VAR_ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')  // Store AWS access key in Jenkins credentials
        TF_VAR_SECRET_KEY = credentials('AWS_SECRET_ACCESS_KEY')  // Store AWS secret key
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo.git'  // Update with your repo details
            }
        }

        stage('Initialize Terraform') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Validate Terraform') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Plan Terraform') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Apply Terraform') {
            steps {
                input message: "Apply the Terraform changes?"  // Manual approval before applying changes
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/*.tfstate', fingerprint: true
        }
        success {
            echo 'Terraform execution successful!'
        }
        failure {
            echo 'Terraform execution failed!'
        }
    }
}
