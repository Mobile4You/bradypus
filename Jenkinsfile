pipeline {
  agent any
  stages {
    stage("Tests / Coverage / Security") {
      steps {
        withDockerContainer(image: "crystallang/crystal:0.24.2", args: "-u root") {
          sh "shards install"
          sh "crystal spec spec"
        }
      }
    }
  }
}
