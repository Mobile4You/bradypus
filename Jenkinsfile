pipeline {
  agent any

  environment {
    ANBER_ENV = "test"
    DATABASE_URL = "postgres://thunder:thundercats123@db:5432/bradypus_test"
  }

  stages {
    stage("Tests / Coverage / Security") {
      steps {
        withDockerContainer(image: "amberframework/amber:v0.7.2", args: "-u root --network=jenkins_default --link jenkins_postgres_1:db") {
          sh "shards install"
          sh "amber db create migrate"
          sh "crystal spec spec"
        }
      }
    }
  }
}
