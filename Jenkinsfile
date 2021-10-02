//pipeline {
//
////  agent {
////    //node { label 'workstation' }
////    //label 'JAVA'
////    any
////  }
//
//  agent  any
//
//  stages {
//
//    stage('Master Node') {
//      agent {
//        label 'MASTER'
//      }
//      steps {
//        sh 'echo Hello'
//      }
//    }
//
//    stage('Agent Node') {
//      agent {
//        label 'JAVA'
//      }
//      steps {
//        sh 'echo Hello'
//      }
//    }
//
//  }
//
//  post {
//
//    always {
//      sh 'echo Post Steps'
//    }
//
//  }
//
//}

pipeline {
  agent any
  options { disableConcurrentBuilds() }
  tools {
    maven 'maven'
  }

  environment {
    DEMO_URL = "google.com"
    SSH = credentials('CENTOS_SSH')
    AWS_ACCESS_KEY_ID=credentials('secrettext')
    AWS_SECRET_ACCESS_KEY=credentials('secrettext')
  }

  parameters {
    string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
    booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')
    choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
    password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
  }

  stages {
    stage('One') {
      environment {
        DEMO_URL = "yahoo.com"
      }
      steps {
        sh 'echo ${DEMO_URL}'
        echo "${SSH_USR}"
        echo "PERSON = ${PERSON}"
      }
    }

    stage('Compile') {
      input {
        message "Should we continue?"
        ok "Yes, we should."
//        submitter "alice,bob"
//        parameters {
//          string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
//        }
      }
      steps {
        sh 'ls'
      }
    }

    stage('Three') {
      parallel {
        stage('P1') {
          steps {
            sh 'sleep 30'
          }
        }
        stage('P2') {
          steps {
            sh 'sleep 30'
          }
        }
        stage('P3') {
          steps {
            sh 'sleep 30'
          }
        }
      }
    }

  }
}