# Deploy Docker image with Jenkins to GKE


1. Setup Jenkins server and node
2. Adding node to jenkins
3. Create and enable a GitHub repository webhook  
4. Cretating codes(Dockerfile,Jenkinsfile,deployment.yaml)
5. Create a Jenkins pipeline project
### Credentials which we need:
dockerhub username:password
GCP service account key


#  Setup Jenkins server and node
We need  2 servers for this one for Master and one for Node. In my case Ubuntu 20.04 OS  

Let's setup Jenkins master .
1. Java 11 or 8
2. Jenkins
3. Firewall give access
    
        sudo apt update
    
        sudo apt install default-jre -y
    
        sudo apt install default-jdk -y 

        wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

        sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

        sudo apt update

        sudo apt install jenkins -y

        sudo systemctl start jenkins

        sudo ufw allow 8080
    
        sudo ufw allow OpenSSH
    
        sudo ufw enable -y
    
        sudo ufw status 

write http://ipaddress_of_jenkins_master:8080

1. Install suggested plugin
![](https://docs.bitnami.com/tutorials/_next/static/images/install-plugins-6b4fff2325c3b270f186ec1c34c098d9.png.webp)

2. Create admin user

3. Install additional plugin

![](https://docs.bitnami.com/tutorials/_next/static/images/installed-plugins-28e08b824fb09220f6daab446a834569.png.webp)

>Confirm the Jenkins server URL and wait for Jenkins to install the selected plugins. In some cases, Jenkins may prompt you to restart and log in again.

>Navigate to the "Manage Jenkins -> Manage Plugins" page.

>On the resulting page, select the "Installed" tab and confirm that the "Docker Pipeline" and "GitHub" plugins are installed (these are included by default with the Bitnami Jenkins stack).

>Select the "Available" tab and select the "Google Kubernetes Engine" plugin. Click the "Install without restart" button. Wait for the plugin to be installed and become available for use.

![](https://docs.bitnami.com/tutorials/_next/static/images/install-gke-plugin-aa40ecf7f4f13fd9f6df6955ef83e2b6.png.webp)

# Node server 


### 1. Java  

        sudo apt update
        sudo apt install default-jre -y
        sudo apt install default-jdk -y 
### 2. Git

        sudo apt install git
### 3. Kubectl 

        sudo apt update
        sudo apt install snapd
        sudo snap install kubectl --classic
### 4. Docker 

        sudo snap install docker
        sudo chmod 666 /var/run/docker.sock
        
### 5. Minikube cluster

        sudo snap install minikube
        minikube start --driver=docker



### 6. Generate key to connect with master Jenkins

        ssh-keygen
        cd .ssh
        cat id_rsa.pub > authorized_keys

# Adding node to jenkins
        
>To configure the Master server, we'll log in to the Jenkins server and follow the steps below.

>First, we'll go to **“Manage Jenkins -> Manage Nodes -> New Node”** to create a new node:

![](https://www.baeldung.com/wp-content/uploads/2021/07/Manage-nodes.png)

>On the next screen, we **enter the “Node Name” (slaveNode1), select “Permanent Agent”, then click “OK”**:

![](https://www.baeldung.com/wp-content/uploads/2021/07/new-node-1.png)

>After clicking “OK”, we'll be taken to a screen with a new form where we need to fill out the slave node's information. We're considering the slave node to be running on Linux operating systems, hence the launch method is set to “Launch agents via ssh”.

>In the same way, we'll add relevant details, such as the name, description, and a number of executors.

>We'll save our work by pressing the “Save” button. The “Labels” with the name **“node1”** will help us to set up jobs on this slave node:

![](https://i.imgur.com/ziyUXGR.png)

> **Manage Jenkins>Manage Credentials**

![](https://i.imgur.com/Z9VXRAp.png)

>Click **(global)>Add credentials**

![](https://i.imgur.com/w1VFXZr.png)
![](https://i.imgur.com/ZTnI4Pr.png)

Add credetials of node server
Type of credentials is 
1. ssh with private key

![](https://i.imgur.com/MgBw39O.png)

2. Add dockerhub credentials

![](https://i.imgur.com/ygfKPj9.png)
 
3. Jenkins will interact with the Kubernetes cluster using a Google Cloud Platform service account. Your next step is to set up this service account and give it API access. Follow these steps:

>Log in to Google Cloud Platform and select your project.
Navigate to the "IAM & admin -> Service accounts" page and create a new service account. Learn more about creating service accounts in the Google >Cloud Platform documentation.
>Create a new JSON key for the service account. Download and save this key, as it will be needed by Jenkins.

![](https://docs.bitnami.com/tutorials/_next/static/images/create-sa-key-df57bca937630a5b9a186a5d62613a39.png.webp)
![](https://docs.bitnami.com/tutorials/_next/static/images/assign-sa-role-0fc4fa97022a6224cd8c38826a32b29b.png.webp)
![](https://i.imgur.com/CzM7o4c.png)


#  Create and enable a GitHub repository webhook
Next, create a GitHub repository and configure it such that GitHub automatically notifies Jenkins about new commits to the repository via a webhook.

>Log in to GitHub and create a new repository. Note the HTTPS URL to the repository.
![](https://docs.bitnami.com/tutorials/_next/static/images/github-url-842c5fdc4168d33c67507e93351a9dc2.png.webp)

>Click the "Settings" tab at the top of the repository page.
>Select the "Webhooks" sub-menu item. Click "Add webhook".
>In the "Payload URL" field, enter the URL http://IP-ADDRESS/jenkins/github-webhook/, replacing the IP-ADDRESS placeholder with the IP address if your Jenkins deployment.

![](https://docs.bitnami.com/tutorials/_next/static/images/create-github-webhook-10f7c5428dee916c038f2d269e6578c4.png.webp)
>Ensure that "Just the push event" radio button is checked and save the webhook.



#  Cretating codes

### Dockerfile
  
    FROM amazonlinux
    
    RUN yum -y update
    RUN yum -y install httpd
    
    COPY ./htmls   /var/www/html/
    
    
    CMD ["/usr/sbin/httpd","-D", "FOREGROUND"]
    EXPOSE 80

### deployment.yaml

    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: todo-deployment
      labels:
        app: todo
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: todo
      template:
        metadata:
          labels:
            app: todo
        spec:
          containers:
          - name: todo
            image: beknazar007/to_do_image:latest
            ports:
            - containerPort: 80
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: my-service
    spec:
      selector:
        app: todo
      ports:
        - protocol: TCP
          port: 80
          targetPort: 80
      type: LoadBalancer

### Jenkinsfile

    pipeline {
    agent {label 'node1'}
    environment {
        PROJECT_ID = 'circle-ci-demo-343616'
        CLUSTER_NAME = 'cluster-1'
        LOCATION = 'us-central1-c'
        CREDENTIALS_ID = 'circle-ci-demo'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build image') {
            steps {
                script {
                    app = docker.build("beknazar007/to_do_image:${env.BUILD_ID}")
                    }
            }
        }
        
        stage('Push image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'name')]) {
                        sh ('docker login -u $name -p $pass ')
                    }
                    app.push("${env.BUILD_ID}")
                 }
                                 
            }
        }

            
 
    
        stage('Deploy to K8s') {
            steps{
                sh "sed -i 's/to_do_image:latest/to_do_image:${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            
                }
            }
        }  
    }  


#  Create a Jenkins pipeline project
At this point, you are ready to start setting up your Jenkins pipeline. Follow the steps below to create a new project.

>Log in to Jenkins (if you're not already logged in).
>Click "New item". Enter a name for the new project and set the project type to "Pipeline". Click "OK" to proceed.

![](https://docs.bitnami.com/tutorials/_next/static/images/create-pipeline-38070ad07ab3354e39a0a1af4e155908.png.webp)

>Select the "General" tab on the project configuration page and check the "GitHub project" checkbox. Enter the complete URL to your GitHub project.
>Select the "Build triggers" tab on the project configuration page and check the "GitHub hook trigger for GITScm polling" checkbox.

![](https://docs.bitnami.com/tutorials/_next/static/images/configure-pipeline-1-02fe0d4e286af39dbcd5bf759bdaa4a9.png.webp)

>Select the "Pipeline" tab on the project configuration page and set the "Definition" field to "Pipeline script from SCM". Set the "SCM" field to "Git" and enter the GitHub repository URL. Set the branch specifier to "*/master". This configuration tells Jenkins to look for a pipeline script named Jenkinsfile in the code repository itself.

![](https://docs.bitnami.com/tutorials/_next/static/images/configure-pipeline-2-819993e30d8d357ffe1561c83213e990.png.webp)
# Run job

![](https://i.imgur.com/pl35cIh.png)

# Errors
1.start minikube cluster in docker

      minikube start --driver=docker

![](https://i.imgur.com/m9ejgCf.png)
2. 
     
      sudo chmod 666 /var/run/docker.sock

![](https://i.imgur.com/E2T3f4E.png)

3. Check  your deployment.yaml file Syntax 
![](https://i.imgur.com/wYZWQxN.png)

how to install jenkins in GKE with HELM
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm install jenkins -n jenkins bitnami/jenkins