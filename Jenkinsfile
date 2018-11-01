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
      sh "make pull_secrets ENV=${params.ENV}"
      sh "make use_secrets ENV=${params.ENV}"
      sh "make build VERSION=${env.BUILD_NUMBER}"
    }
    stage('Test') {
      sh 'make test'
    }
    stage('Push image') {
      sh "make tag VERSION=${env.BUILD_NUMBER}"
      sh "make push VERSION=${env.BUILD_NUMBER}"
    }
    stage('Deploy') {
      echo 'Deploy will be launched from here'
    }
  }
}