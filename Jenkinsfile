node {
   def mvnHome
   stage('Preparation') { 
      git 'https://github.com/deepaked1/spring-petclinic.git'
      mvnHome = tool 'M3'
   }
   stage('Build') {
      withEnv(["MVN_HOME=$mvnHome"]) {
            sh '"$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore -s $MAVEN_SETTINGS clean package'
      }
   }
}