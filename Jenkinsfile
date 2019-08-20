node {
   stage('Preparation') {
      // Get code from the GitLab repository
      git 'http://gitlab/root/xl-golang-demo-app.git'
   }
   stage('Build App Executables') {
      withEnv(["PATH=$PATH:/opt/go/bin:/usr/local/go/bin"]) {
        sh 'go build wiki.go'
      }
   }
   stage('Scan Artifacts') {
      withEnv(["DOCKER_HOST=tcp://dind:2375"]) {
        sh 'docker build -f DockerfileScan -t sonar-scanner:latest .'
        sh 'docker run --rm -t sonar-scanner -Dsonar.projectKey=xl-golang-demo-app -Dsonar.host.url=http://sonarqube:9009 -Dsonar.login=${SONARTOKEN}'
      }
   }
   stage('Results') {
      archiveArtifacts artifacts: 'wiki', fingerprint: true
   }
}