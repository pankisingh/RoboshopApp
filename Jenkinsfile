// pipeline{
//     // agent{
//     //    node{label 'workstation'}
//     // }
//     agent any
//     stages{
//         stage("one"){
//             agent{
//                 label 'java'
//             }

//             steps{
//                 echo "========executing one========"
//             }
//         }
//         stage("Two"){
//             agent{
//                 label 'master'
//             }
//             steps{
//                 echo "========executing Two========"
//             }
//         }
       
//     }
//     post{
//         //agent any
//         always{
//             echo "===========Post running=========="
//         }
//     }
          
// }

pipeline{
    agent any
    environment{
        Demo_Url = "google.com"
    }
    stages{
        stage("one"){
            steps{
                sh 'echo {$Demo_Url}'
            }
            
        }
    }
    
}