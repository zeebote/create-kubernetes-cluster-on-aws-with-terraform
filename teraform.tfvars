region      = "us-east-1"
agent_count = "2"
# Ubuntu 18.04 image
ami                    = "ami-03fac5402e10ea93b"
instance_type          = "t2.micro"
iam_instance_profile   = "s3ReadOnly"
key_name               = "your-private-keypair"
# comment out next line if you want to use group name otherwise use id
# security_groups   = ["default", "ssh"]
vpc_security_group_ids = ["sg-00a3sdfd9f5b937", "sg-24456350"]
