node (‘master’) {
     def dockerTool = tool name: ‘docker’ ,type: ‘org.jenkinsci.plugins.docker.commons.tools.DockerTool’
     withEnv([“DOCKER=${dcokerTool}/bin”]) {
        //stages
       //here we can trigger: sh “sudo ${DOCKER}/docker …”
    }
}
def dockerCmd(args) {
       sh “sudo ${DOCKER}/docker ${args}”
}
stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
}
stage('Build') {
       withMaven(maven: 'Maven 3') {
           dir(‘app’) {
            sh 'mvn clean package'
            dockerCmd ‘build —tag gc25/demoapp’
           }
       }
 }
stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        app = docker.build("gc25/demoapp")
}
stage('Test image') {
        /* Ideally, we would run a test framework against our image.
         * For this example, we're using a Volkswagen-type approach ;-) */
          app.inside {
           sh 'echo "Tests passed"'
           }
       }
stage('Push image') {
         /* Finally, we'll push the image with two tags:
          * First, the incremental build number from Jenkins
          * Second, the 'latest' tag.
          * Pushing multiple tags is cheap, as all the layers are reused. */
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
      }
}
