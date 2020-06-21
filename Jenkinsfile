pipeline {
  agent any
  stages {
    stage('compile') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
  }
}