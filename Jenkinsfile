pipeline {
    agent any

    environment {
        ImageRegistry = 'oluwaseuna'
    }


    stages{
        stage("buildImage") {
            steps{
                script {
                    echo "Build Docker Image"
                    sh "docker build -t ${ImageRegistry}-${JOB_NAME}:${BUILD_NUMBER} ."
                }
            }
        }

        stage("pushImage") {
            steps{
                script {
                    echo "pushing Image to dockerhub"
                    withCredentials([usernamePassword(credentialsId: 'docker-login', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push ${ImageRegistry}-${JOB_NAME}:${BUILD_NUMBER} "
                    }
                }
            }
        }
    }
}