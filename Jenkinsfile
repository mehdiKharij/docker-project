pipeline {
    agent any

    environment {
        ImageRegistry = 'oluwaseuna'
        EC2_IP = '34.255.98.175'
        DockerComposeFile = 'docker-compose.yml'
        DotEnvFile = '.env'
        DockerImageTag = "${ImageRegistry}/${JOB_NAME}:${BUILD_NUMBER}"
    }

    stages {

        stage("buildImage") {
            steps {
                script {
                    echo "Building Docker Image..."
                    sh "docker build -t ${DockerImageTag} ."
                }
            }
        }

        stage("pushImage") {
            steps {
                script {
                    echo "Pushing Image to DockerHub..."
                    withCredentials([usernamePassword(credentialsId: 'docker-login', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push ${DockerImageTag}"
                    }
                }
            }
        }

        stage("deployCompose") {
            steps {
                script {
                    echo "Deploying with Docker Compose..."
                    sshagent(['ec2']) {
                        sh """
                        # Copy files to EC2 instance
                        scp -o StrictHostKeyChecking=no ${DotEnvFile} ${DockerComposeFile} ubuntu@${EC2_IP}:/home/ubuntu

                        # Pull the latest Docker image and restart services
                        ssh -o StrictHostKeyChecking=no ubuntu@${EC2_IP} "
                            export docker_image=${DockerImageTag} && \
                            docker compose -f /home/ubuntu/${DockerComposeFile} --env-file /home/ubuntu/${DotEnvFile} down && \
                            docker compose -f /home/ubuntu/${DockerComposeFile} --env-file /home/ubuntu/${DotEnvFile} up -d
                        "
                        """
                    }
                }
            }
        }
    }
}