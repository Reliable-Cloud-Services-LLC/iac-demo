pipeline{
    agent any
    tools {
  terraform 'terraform'
}

stages{
    stage('Git checkout'){
        steps(){
           checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'c46a3e2b-dfcb-4f69-b874-9078d524171c', url: 'https://github.com/Reliable-Cloud-Services-LLC/iac-demo.git']]])
            
        }
    }
    stage('Terraform init'){
        steps{
           sh '''cd eks
          terraform init'''
        }
    }
    
    
    stage('Terraform plan'){
        steps{
          sh '''cd eks
         terraform plan'''
       }
    }
     stage('Terraform apply'){
        steps{
             sh '''cd eks
                terraform apply --auto-approve'''
        }
    } 
       stage('Terraform Destroy'){
        sh '''cd /var/lib/jenkins/workspace/eks_cluster_pipeline/eks
       terraform destroy'''
    }
}
}
