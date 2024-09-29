pipeline {
    agent any


    stages{
        stage("buildImage") {
            steps{
                script {
                    echo "Build Docker Image"
                    sh 'docker ps -a'
                }
            }
        }
    }
}