pipeline{
   agent any
    stages{
        stage("Terraform Init"){
            steps{
                sh 'cd Terraform; cd roboshop-shell-scripting; terraform init -reconfigure'
            }
        }
         stage("Terraform destroy"){
            steps{
                sh '''
                    cd Terraform
                    cd roboshop-shell-scripting
                    terraform destroy -auto-approve
                '''
            }
        }
    }
           
}