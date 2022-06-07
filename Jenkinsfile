pipeline{
    agent any
    tools {
  terraform 'terraform'
}

stages{
    stage('Git checkout'){
        steps(){
           checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'c46a3e2b-dfcb-4f69-b874-9078d524171c', url: 'https://github.com/Reliable-Cloud-Services-LLC/iac-demo.git']]])
            sh 'cd eks'
        }
    }
    stage('Terraform init'){
        steps{
            sh  'cd eks'        
            sh 'terraform init'
        }
    }
    
    
    stage('Terraform plan'){
        steps{
          sh 'cd eks'
           sh 'terraform plan'
       }
    }
    
    
}
}
