pipeline {
    agent {
        node {
        label 'build && docker'
        }
    }

    stages {

        stage('Build da imagem Airflow personalizada') {
            steps {
                sh 'docker build -t airflow:2.6 .'
            }
        }
    }
}
