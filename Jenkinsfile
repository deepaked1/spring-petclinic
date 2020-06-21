pipeline {
  agent none
  stages {
    stage('compile') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
  }
}