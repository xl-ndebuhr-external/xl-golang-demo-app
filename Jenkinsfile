node {
   stage('Build App Executables') {
      withEnv(["PATH=$PATH:/opt/go/bin:/usr/local/go/bin"]) {
        sh 'go build wiki.go'
      }
   }
   stage('Results') {
      archiveArtifacts artifacts: 'wiki', fingerprint: true
   }
}