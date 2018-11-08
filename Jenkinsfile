pipeline {
  agent any
  stages {
    stage('Prepare') {
      steps {
        checkout scm
        sh 'touch .env'
      }
    }
    stage('Build') {
      steps {
        sh "make pull_secrets ENV=${params.ENV}"
        sh "make use_secrets ENV=${params.ENV}"
        sh "make build VERSION=${'build_' + env.BUILD_NUMBER}"
      }
    }
    stage('Test') {
      steps {
        sh 'make test'
      }
    }
    stage('Push image') {
      steps {
        sh "\$(aws ecr get-login --no-include-email --region us-east-1)"
        sh "make tag VERSION=${'build_' + env.BUILD_NUMBER}"
        sh "make push VERSION=${'build_' + env.BUILD_NUMBER}"
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploy will be launched from here'
      }
    }
  }
  post {
    always {
      sh 'make stop'
      cleanWs()
      sh 'docker rmi $(docker images -qa)'
    }
  }
}