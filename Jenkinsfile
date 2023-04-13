pipeline {
    agent any
    stages {
        stage('clone repo') {
            steps {
                git(
                    url:"https://github.com/masoudn84/terraform-aws.git"
                )
            }
        }
        stage('apply terraform') {
            steps {
                script{
                sh 'terraform init'
                sh 'terraform fmt'
                sh 'terraform validate' 
                sh 'terraform plan -out export.tfplan >plan.txt'
                sh 'terraform apply -auto-approve'
                sh '''if [ -e "vm_ip.txt" ];then
    echo "hi"
    count=0
    while read line;do
    echo $line
    sed -i  "0,/%node%/s//${line}/" hosts.yaml
    done <vm_ip.txt
    else 
    exit 11
    fi
    '''}
            }
        }
        stage('clone ansible repo'){
            steps {
                git(
                    url: 'https://github.com/masoudn84/iac_jenkins.git'
                )
            }
        }
        stage('run ansible playbook') {
            script {sh 'ansible-playbook -i hosts.yaml'}
        }
    }
}
