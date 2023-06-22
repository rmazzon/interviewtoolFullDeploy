pipeline {

    stages {

        stage('Creazione dashboard') {

            steps {

                build job: 'Dashboard Kubernetes'
                
            }

        }

// Deploy dei servizi, prima gateway che fornisce l'ip a frontend, poi user per la creazione delle chiavi utilizzate dagli altri microservizi e infine il frontend
        stage('Deploy gateway') {

            steps {

                build job: 'gateway', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Deploy user microservice') {

            steps {

                build job: 'user', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Deploy question microservice') {

            steps {

                build job: 'question', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Deploy quiz microservice') {

            steps {

                build job: 'quiz', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Deploy template microservice') {

            steps {

                build job: '', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }
        
        stage('Deploy frontend') {

            steps {

                build job: 'frontend', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Popolamento database') {

            steps {



            }

        }

    }

}