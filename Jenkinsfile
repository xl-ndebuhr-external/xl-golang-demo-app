node {
   stage('Preparation') {
      // Get code from the GitLab repository
      git '${REPO}'
   }
   stage('Build App Executables') {
      withEnv(["PATH=$PATH:/opt/go/bin:/usr/local/go/bin"]) {
        sh 'go build wiki.go'
      }
   }
   stage('Scan Artifacts') {
      withEnv(["DOCKER_HOST=${DOCKERHOST}"]) {
        sh 'docker build -f DockerfileScan -t sonar-scanner:latest .'
        sh 'docker run --rm -t sonar-scanner -Dsonar.projectKey=xl-golang-demo-app -Dsonar.host.url=${SONARHOST} -Dsonar.login=${SONARTOKEN}'
      }
   }
   stage('Archive Artifacts') {
      archiveArtifacts artifacts: 'wiki', fingerprint: true
   }
   stage('Build App Docker Image') {
      withEnv(["DOCKER_HOST=${DOCKERHOST}"]) {
        sh 'docker build -t devops-wiki:latest .'
      }
   }
}