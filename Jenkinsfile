pipeline {
  agent any

  environment {
    PRODUCT = "bradypus"
    BUILD_NUMBER = "${env.BUILD_ID}"
    DOCKER_REPOSITORY = "m4ucorp/bradypus"
    METRIC_APP_NAME = "BRADYPUS"

    ANBER_ENV = "test"
    DATABASE_URL = "postgres://thunder:thundercats123@db:5432/bradypus_test"
  }

  stages {
    stage("Tests") {
      steps {
        withDockerContainer(
            image: "amberframework/amber:v0.7.2",
            args: "-u root --network=jenkins_default --link jenkins_postgres_1:db") {
          sh "shards install"
          sh "amber db create migrate"
          sh "crystal spec spec"
        }
      }
    }

    stage("Docker") {
      when { branch "master" }
      steps {
        withDockerRegistry([credentialsId: "dockerhub-credentials", url: ""]) {
          script {
            commit = getCommitId().take(6)
            def image = docker.build(
                "${DOCKER_REPOSITORY}:${env.BUILD_ID}-${commit}", '.')
            image.push()
          }
        }
      }
    }
  }
}

def getCommitId() {
  exec('git rev-parse HEAD')
  readFile('result').trim()
}
