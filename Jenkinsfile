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
   stage('Results') {
      archiveArtifacts artifacts: 'wiki', fingerprint: true
   }
}