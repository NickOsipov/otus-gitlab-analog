pipeline {
    agent any

    environment {
        DEPLOY_PATH = '/home/ubuntu/fastapi-app'
        DOCKER_HUB_USER = credentials('docker-hub-user')
        DOCKER_HUB_TOKEN = credentials('docker-hub-token')
        SSH_USER = credentials('ssh-user')
        DEPLOY_HOST = credentials('deploy-host')
    }

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'docker:27-cli'
                    args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'apk add make bash'
                sh 'bash scripts/create-dotenv.sh'
                sh 'make build'
                sh 'make push'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'docker:27-cli'
                    args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                sh 'apk add make bash'
                sh 'bash scripts/create-dotenv.sh'
                sh 'make test-in-docker'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'ssh-private-key', keyFileVariable: 'SSH_KEY')]) {
                        sh '''
                            bash scripts/create-dotenv.sh
                            mkdir -p ~/.ssh
                            chmod 700 ~/.ssh
                            cp $SSH_KEY ~/.ssh/id_rsa
                            chmod 600 ~/.ssh/id_rsa
                            ssh-keyscan $DEPLOY_HOST >> ~/.ssh/known_hosts
                            chmod 644 ~/.ssh/known_hosts
                            make deploy
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

