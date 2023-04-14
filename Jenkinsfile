pipeline {
    agent any
    stages {
        stage('clone repo') {
            steps {
                git(
                    url:"https://github.com/masoudn84/terraform-aws.git",
                    branch: "main"
                )
                script{ sh "ls"
                        sh "pwd"
                }
            }
        }
        stage('apply terraform') {
            steps {
                withCredentials(
                    [string(credentialsId: 'aws_access_key', variable: 'aws_access_key'),
                     string(credentialsId: 'aws_secret_key', variable: 'aws_secret_key')]) {
                sh "ls"
                sh 'terraform init'
                sh 'terraform apply -auto-approve -var aws_access_key=aws_access_key -var aws_secret_key=aws_secret_key'
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
            steps{script {sh 'ansible-playbook -i hosts.yaml'}}
        }
    }
}
