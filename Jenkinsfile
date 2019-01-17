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
        image = "877366825671.dkr.ecr.us-east-1.amazonaws.com/storytelling-example:${'build_' + env.BUILD_NUMBER}"
        sh "ansible-playbook -i deploy/group_vars/server -s deploy/deploy.yml --extra-vars='docker_image=:${image}'"
      }
    }
  }
  post {
    always {
      sh 'make stop'
      cleanWs()
      sh 'make remove_image'
    }
  }
}