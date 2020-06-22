node {
   def mvnHome
   def dockerHome
   stage('Preparation') { 
      git 'https://github.com/deepaked1/spring-petclinic.git'
      mvnHome = tool 'M3'
      mvnHome = tool 'Docker'
   }
   stage('Build') {
      withEnv(["DOCKER_HOME=$mvnHome"]) {
	      sh '$DOCKER_HOME/bin/docker build'
      }
      withEnv(["MVN_HOME=$mvnHome"]) {
            sh 'echo $("$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore -s $MAVEN_SETTINGS clean package)'
      }
   }
}