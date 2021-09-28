pipeline{
   agent any
    stages{
        stage("Terraform Init"){
            steps{
                sh 'cd Terraform; cd roboshop-shell-scripting; terraform init -reconfigure'
            }
        }
         stage("Terraform apply"){
            steps{
                sh '''
                    cd Terraform
                    cd roboshop-shell-scripting
                    terraform apply -auto-approve
                '''
            }
        }
    }
           
}