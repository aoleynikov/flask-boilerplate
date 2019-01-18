def image = "877366825671.dkr.ecr.us-east-1.amazonaws.com/storytelling-example:${'build_' + env.BUILD_NUMBER}"

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
        sh "make build"
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
        sh "make tag IMAGE=${image}"
        sh "make push IMAGE=${image}"
      }
    }
    stage('Deploy') {
      steps {
        sh '''
          echo $AWS_ACCESS_KEY_ID
          echo $AWS_SECRET_ACCESS_KEY
          ansible-playbook -i deploy/group_vars/${params.ENV} -s deploy/deploy.yml --extra-vars='docker_image=${image} aws_key=${$AWS_ACCESS_KEY_ID} aws_secret=${AWS_SECRET_ACCESS_KEY}'
        '''
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