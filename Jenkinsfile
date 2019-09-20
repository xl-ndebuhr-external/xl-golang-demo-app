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
        sh 'docker run -v $PWD:/usr/src --rm -t newtmitch/sonar-scanner:4 -Dsonar.projectKey=xl-golang-demo-app -Dsonar.host.url=${SONARHOST} -Dsonar.login=${SONARTOKEN}'
      }
   }
   stage('Build App Docker Image') {
      withEnv(["DOCKER_HOST=${DOCKERHOST}"]) {
        sh 'docker build --no-cache -t devops-wiki:1.0.$BUILD_NUMBER .'
        sh 'docker tag devops-wiki:1.0.$BUILD_NUMBER ${REGISTRY}/devops-wiki:1.0.$BUILD_NUMBER'
        sh 'echo "${DOCKERPASSWORD}" | docker login -u ${DOCKERUSER} --password-stdin https://${REGISTRY}'
        sh 'docker push ${REGISTRY}/devops-wiki:1.0.$BUILD_NUMBER'
      }
   }
   stage('Setup Deployment Package') {
       sh 'sed -i "s/{{ VERSION }}/1.0.$BUILD_NUMBER/g" manifest.xml'
       sh 'sed -i "s/{{ REGISTRY }}/${REGISTRY}/g" manifest.xml'
       xldCreatePackage artifactsPath: '', darPath: 'output.dar', manifestPath: 'manifest.xml'
       xldPublishPackage darPath: 'output.dar', serverCredentials: 'admin'
   }
   stage('Archive Artifacts') {
      archiveArtifacts artifacts: 'wiki, output.dar', fingerprint: true
   }
}
