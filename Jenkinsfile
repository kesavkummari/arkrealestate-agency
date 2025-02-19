node {
   def mvnHome
   stage('Prepare') {
       git url: 'https://github.com/kesavkummari/arkrealestate-agency.git', branch: 'main'
       mvnHome = tool 'maven'
   }

/*
   stage('Code Quality') {
       try {
           sh "'${mvnHome}/bin/mvn' sonar:sonar"
       } catch (Exception e) {
           error "SonarQube analysis failed. Stopping pipeline execution."
       }
   }
*/
   stage('Clean') {
       sh "'${mvnHome}/bin/mvn' clean"
   }

   stage('Validate') {
       sh "'${mvnHome}/bin/mvn' validate"
   }

   stage('Compile') {
       sh "'${mvnHome}/bin/mvn' compile"
   }

   stage('Test') {
       sh "'${mvnHome}/bin/mvn' test"
   }

   stage('Package') {
       sh "'${mvnHome}/bin/mvn' package"
   }

   stage('Verify') {
       sh "'${mvnHome}/bin/mvn' verify"
   }

   stage('Install') {
       sh "'${mvnHome}/bin/mvn' install"
   }
/*
   stage('Deliver & Deployment') {
       sh 'curl -u admin:redhat@123 -T target/**.war "http://3.87.125.112:8080/manager/text/deploy?path=/kesav&update=true"'
   }

   stage('SmokeTest') {
       sh 'curl --retry-delay 10 --retry 5 "http://3.87.125.112:8080/kesav"'
   }
*/
}
