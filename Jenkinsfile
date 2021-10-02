pipeline{
    // agent{
    //    node{label 'workstation'}
    // }
    agent none
    stages{
        stage("one"){
            agent{
                label 'java'
            }

            steps{
                echo "========executing one========"
            }
        }
        stage("Two"){
            agent{
                label 'master'
            }
            steps{
                echo "========executing Two========"
            }
        }
       
    }
    post{
        agent any
        always{
            echo "===========Post running=========="
        }
    }
          
}