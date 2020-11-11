# create-kubernetes-cluster-on-aws-with-terraform
Launch a Kubernetes cluster with EC2 instances using Terraform <br>
**Requirements:**
1. AWS CLI - Please follow this [link](https://aws.amazon.com/cli/) for installation and information about AWS CLI
1. AWS account with access key to your EC2 - You can use an existing account or create a new one with AWS IAM console then go to manage access key and generate 
a new key. This account must have IAM role which have minimum policy to create instances in EC2. Please follow this [link](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html) for information how to create IAM role and generate a key pair. <br> 
1. Terraform - Please follow this [link](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) for how to install Terraform <br>

**How to use**
1. Configure AWS credential: 
   - Invoke credential configuration with AWS CLI and follow on screen instruction enter aws_access_key_id, aws_secret_access_key, region, output (json) <br>
   ```
   aws configure
   AWS Access Key ID [None]:Your AWS Access Key
   AWS Secret Access Key [None]: Your AWS Secret Access Key 
   Default region name [None]: us-east-1
   Default output format [None]: json
   ```
1. Prepare workspace and clone this repo: 
   ```
   mkdir kb-cluster && cd kb-cluster
   git clone https://github.com/zeebote/create-kubernetes-cluster-on-aws-with-terraform .
   ```
1. Initilialize Terraform and check:
   ```
   terraform init
   terraform plan
   ```
   - To deploy: 
   ```
   terraform deploy
   ```
   You must enter "yes" for confirmation then we should see the result: <br>
   ```
   Apply complete! Resources: 5 added, 0 changed, 0 destroyed.
   Outputs:
   Agent-Nodes = {
   "i-0014da95a2e6169bf" = [
    "172.31.18.196",
    "3.101.34.113",
   ]
   "i-06d98d6438abb7ada" = [
    "172.31.27.87",
    "54.183.237.222",
   ]
   }
   Master-Node = [
   "i-00f4b5f74416581d6",
   "172.31.30.44",
   "54.193.214.98",
   ]
   ```
1. Verification:
   - Login to master node:
   ```
   ssh -i private-key-pair ubuntu@54.193.214.98 
   ubuntu@ip-172-31-30-44:~$ kubectl get node
   NAME               STATUS   ROLES    AGE     VERSION
   ip-172-31-18-196   Ready    <none>   4m23s   v1.19.3
   ip-172-31-27-87    Ready    <none>   4m24s   v1.19.3
   ip-172-31-30-44    Ready    master   4m48s   v1.19.3
   ```
   - Check running containers:
   ```
   kubectl get pod --all-namespaces
   kube-system   coredns-f9fd979d6-hpwgm                   1/1     Running   0          4m54s   10.244.1.2      ip-172-31-27-87        
   kube-system   coredns-f9fd979d6-ngh6f                   1/1     Running   0          4m54s   10.244.2.2      ip-172-31-18-196
   kube-system   etcd-ip-172-31-30-44                      1/1     Running   0          5m10s   172.31.30.44    ip-172-31-30-44    
   kube-system   kube-apiserver-ip-172-31-30-44            1/1     Running   0          5m10s   172.31.30.44    ip-172-31-30-44   
   kube-system   kube-controller-manager-ip-172-31-30-44   1/1     Running   0          5m10s   172.31.30.44    ip-172-31-30-44   
   kube-system   kube-flannel-ds-fvz4l                     1/1     Running   0          4m40s   172.31.18.196   ip-172-31-18-196 
   kube-system   kube-flannel-ds-nfrmz                     1/1     Running   0          4m40s   172.31.30.44    ip-172-31-30-44 
   kube-system   kube-flannel-ds-shfbz                     1/1     Running   0          4m40s   172.31.27.87    ip-172-31-27-87 
   kube-system   kube-proxy-9jlcx                          1/1     Running   0          4m51s   172.31.27.87    ip-172-31-27-87   
   kube-system   kube-proxy-dx7fg                          1/1     Running   0          4m54s   172.31.30.44    ip-172-31-30-44   
   kube-system   kube-proxy-l55nn                          1/1     Running   0          4m50s   172.31.18.196   ip-172-31-18-196  
   kube-system   kube-scheduler-ip-172-31-30-44            1/1     Running   0          5m10s   172.31.30.44    ip-172-31-30-44   
   ```
1. Next step? Store your Terraform remote state to share it with your team. For more information please follow this [link](https://learn.hashicorp.com/tutorials/terraform/aws-remote?in=terraform/aws-get-started) for store remote state with Terraform cloud.

   
