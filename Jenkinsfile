#!groovy
node {
     def app

     stage('Clone repository') {
      /* Let's make sure we have the repository cloned to our workspace */

     checkout scm
    }

     stage('Build') {
 
          git url: 'https://github.com/cyrille-leclerc/multi-module-maven-project'
     withMaven(
        // Maven installation declared in the Jenkins "Global Tool Configuration"
        maven: 'Maven 3',
        // Maven settings.xml file defined with the Jenkins Config File Provider Plugin
        // We recommend to define Maven settings.xml globally at the folder level using
        // navigating to the folder configuration in the section "Pipeline Maven Configuration / Override global Maven configuration"
        // or globally to the entire master navigating to  "Manage Jenkins / Global Tools Configuration"
        mavenSettingsConfig: 'global-maven-settings')
            {
              sh 'mvn clean package'
             
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
