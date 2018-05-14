pipeline {
  agent any

  environment {
    ANBER_ENV = "test"
    DATABASE_URL = "postgres://thunder:thundercats123@postgres:5432/bradypus_test"
  }

  stages {
    stage("Tests / Coverage / Security") {
      steps {
        withDockerContainer(image: "crystallang/crystal:0.24.2", args: "-u root --link postgres") {
          sh "shards install"
          sh "amber db create migrate"
          sh "crystal spec spec"
        }
      }
    }
  }
}
