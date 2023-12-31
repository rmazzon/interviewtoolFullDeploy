pipeline {

    agent any

    parameters {
        booleanParam(name: 'user', defaultValue: true, description: 'Deploy the user microservice?')
        booleanParam(name: 'question', defaultValue: true, description: 'Deploy the question microservice?')
        booleanParam(name: 'quiz', defaultValue: true, description: 'Deploy the quiz microservice?')
        booleanParam(name: 'template', defaultValue: true, description: 'Deploy the template microservice?')
        booleanParam(name: 'database', defaultValue: true, description: 'Populate the database?')
        booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy everything?')
    }


    stages {

        stage('Creazione dashboard') {

            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }

            steps {

                build job: 'Dashboard Kubernetes'
                
            }

        }

// Deploy dei servizi, prima gateway che fornisce l'ip a frontend, poi user per la creazione delle chiavi utilizzate dagli altri microservizi e infine il frontend
        stage('Deploy gateway') {

            when {
                
                not {
                    equals expected: true, actual: params.destroy
                }
            }

            steps {

                build job: 'gateway', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Deploy user microservice') {
            
            when {
                equals expected: true, actual: params.user
                not {
                    equals expected: true, actual: params.destroy
                }
            }

            steps {

                build job: 'user', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Deploy question microservice') {

            when {
                equals expected: true, actual: params.question
                not {
                    equals expected: true, actual: params.destroy
                }
            }

            steps {

                build job: 'question', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Deploy quiz microservice') {

                when {
                equals expected: true, actual: params.quiz
                not {
                    equals expected: true, actual: params.destroy
                }
            }

            steps {

                build job: 'quiz', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }

        stage('Deploy template microservice') {

            when {
                equals expected: true, actual: params.template
                not {
                    equals expected: true, actual: params.destroy
                }
            }

            steps {

                build job: 'template', parameters: [
                    string(name: 'deploy', value: 'true')
                ]
            }

        }
        
        stage('Deploy frontend') {

            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            steps {

                build job: 'frontend', parameters: [
                    string(name: 'deploy', value: 'true'),
                    string(name: 'destroy', value: 'false')
                ]
            }

        }

        stage('Popolamento database') {

            when {
                equals expected: true, actual: params.database
                not {
                    equals expected: true, actual: params.destroy
                }
            }

            steps {
                
                script{

                    withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'aws eks --region us-east-1 update-kubeconfig --name rmazzon-eks-cluster'

                        echo "Populating user database"
                        def deploymentDB = sh(
                            returnStdout: true,
                            script: 'kubectl -n interview-tool get pod | grep "db-user" | awk \'{ print $1 }\''
                        ).trim()
                        withCredentials([usernamePassword(credentialsId: 'DB', usernameVariable: 'USER', passwordVariable: 'SECRET')]) {
                            sh 'kubectl exec -i ' + deploymentDB + ' -n interview-tool -- mysql --password=$SECRET --user=$USER --database=user_db < query/user.sql'
                        }
                    
                        echo "Populating template database"
                        deploymentDB = sh(
                            returnStdout: true,
                            script: 'kubectl -n interview-tool get pod | grep "db-template" | awk \'{ print $1 }\''
                        ).trim()
                        withCredentials([usernamePassword(credentialsId: 'DB', usernameVariable: 'USER', passwordVariable: 'SECRET')]) {
                            sh 'kubectl exec -i ' + deploymentDB + ' -n interview-tool -- mysql --password=$SECRET --user=$USER --database=template_db < query/template.sql'
                        }

                        echo "Populating quiz database"
                        deploymentDB = sh(
                            returnStdout: true,
                            script: 'kubectl -n interview-tool get pod | grep "db-quiz" | awk \'{ print $1 }\''
                        ).trim()
                        withCredentials([usernamePassword(credentialsId: 'DB', usernameVariable: 'USER', passwordVariable: 'SECRET')]) {
                            sh 'kubectl exec -i ' + deploymentDB + ' -n interview-tool -- mysql --password=$SECRET --user=$USER --database=quiz_db < query/quiz.sql'
                        }

                        echo "Populating question database"
                        deploymentDB = sh(
                            returnStdout: true,
                            script: 'kubectl -n interview-tool get pod | grep "db-question" | awk \'{ print $1 }\''
                        ).trim()
                        withCredentials([usernamePassword(credentialsId: 'DB', usernameVariable: 'USER', passwordVariable: 'SECRET')]) {
                            sh 'kubectl exec -i ' + deploymentDB + ' -n interview-tool -- mysql --password=$SECRET --user=$USER --database=question_db < query/question.sql'
                        }

                    }
                }

            }

        }

        stage('Destroy all') {

            when {
                equals expected: true, actual: params.destroy
            }

            steps {
                withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'aws eks --region us-east-1 update-kubeconfig --name rmazzon-eks-cluster'
                    // controllo se il namespce è già stato creato, altrimenti lo creo

                    sh 'kubectl delete namespace interview-tool'

                    sh 'kubectl delete namespace kubernetes-dashboard'
                }
            }

        }

    }

}