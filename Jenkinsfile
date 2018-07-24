pipeline {
    agent {
        node {
            label 'slaveJENKINS'
        }
    }
environment {
    TERRAFORM_CMD = 'sudo docker run --network host -w /app -v /root/.aws:/root/.aws -v /root/.ssh:/root/.ssh -v "${WORKSPACE}/terraform/accessories":/app hashicorp/terraform:light'

TERRAFORM_CMD1 = 'sudo docker run --network host -w /app -v /root/.aws:/root/.aws -v /root/.ssh:/root/.ssh -v "${WORKSPACE}/terraform/network":/app hashicorp/terraform:light'

TERRAFORM_CMD2 = 'sudo docker run --network host -w /app -v /root/.aws:/root/.aws -v /root/.ssh:/root/.ssh -v "${WORKSPACE}/terraform/ELK-Artefacts":/app hashicorp/terraform:light'
    }
      	stages {
          stage('checkout repo') {
            steps {
              git url: 'https://github.com/toketunji/ELK-Tutorial.git'
            }
          }
          stage('pull latest light terraform image') {
            steps {
                sh  """
                    sudo docker pull hashicorp/terraform:light
                    """
            }
          }
          stage('init') {
            steps {
                sh  """
                    cd terraform
                    cd accessories
                    pwd
                    ${TERRAFORM_CMD} init -backend=true -input=false
                    ${TERRAFORM_CMD} plan -out=tfplan -input=false
                    ${TERRAFORM_CMD} apply -lock=false -input=false tfplan
                    """
            }
          }
          stage('plan') {
            steps {
                sh  """
 		    cd terraform
                    cd network
                    pwd
                    ${TERRAFORM_CMD1} init -backend=true -input=false
                    ${TERRAFORM_CMD1} plan -out=tfplan -input=false
                    ${TERRAFORM_CMD1} apply -lock=false -input=false tfplan
                    """
            }
          }  
          stage('apply') {
            steps {
                sh  """
		    cd terraform
                    cd ELK-Artefacts
                    pwd
                    ${TERRAFORM_CMD2} init -backend=true -input=false
                    ${TERRAFORM_CMD2} plan -out=tfplan -input=false
                    ${TERRAFORM_CMD2} apply -lock=false -input=false tfplan
                    """

            }
          }
	  stage('Destroy') {
	    steps {
	      script {
                  timeout(time: 10, unit: 'MINUTES') {
                    input(id: "Deploy Gate", message: "Destroy Infrastructure", ok: 'Deploy')
                  }
	      }
              ansicolor('xterm') {
		  sh """
		      ${TERRAFORM_CMD} destroy -auto-approve -input=false
		      ${TERRAFORM_CMD1} destroy -auto-approve -input=false
                      ${TERRAFORM_CMD2} destroy -auto-approve -input=false
              }     
            } 

         }
