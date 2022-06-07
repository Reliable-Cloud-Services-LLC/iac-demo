#Create a new EC2 launch configuration
resource "aws_instance" "ec2_public" {
ami                    = "ami-0022f774911c1d690"
instance_type               = "${var.instance_type}"
key_name                    = "${var.key_name}"
security_groups             = ["${aws_security_group.ssh-security-group.id}"]
subnet_id                   = "${aws_subnet.public-subnet-1.id}"
associate_public_ip_address = true
user_data = <<EOF
#!/bin/bash
sudo yum update 
sudo yum install default-jdk -y
amazon-linux-extras install epel 
amazon-linux-extras install java-openjdk11  
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo --no-check-certificate
sudo rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins -y
amazon-linux-extras install jenkins
sudo service jenkins enable
sudo service jenkins start
EOF


#iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"
lifecycle {
create_before_destroy = true
}
tags = {
"Name" = "EC2PUBLIC"
}
# Copies the ssh key file to home dir
# Copies the ssh key file to home dir
provisioner "file" {
source      = "./${var.key_name}.pem"
destination = "/home/ec2-user/${var.key_name}.pem"
connection {
type        = "ssh"
user        = "ec2-user"
private_key = file("${var.key_name}.pem")
host        = self.public_ip
}
}
//chmod key 400 on EC2 instance
provisioner "remote-exec" {
inline = ["chmod 400 ~/${var.key_name}.pem"]
connection {
type        = "ssh"
user        = "ec2-user"
private_key = file("${var.key_name}.pem")
host        = self.public_ip
}
}
}
#Create a new EC2 launch configuration
resource "aws_instance" "ec2_private" {
#name_prefix                 = "terraform-example-web-instance"
ami                    = "ami-0022f774911c1d690"
instance_type               = "${var.instance_type}"
key_name                    = "${var.key_name}"
security_groups             = ["${aws_security_group.webserver-security-group.id}"]
subnet_id                   = "${aws_subnet.private-subnet-1.id}"
associate_public_ip_address = false
#user_data                   = "${data.template_file.provision.rendered}"
#iam_instance_profile = "${aws_iam_instance_profile.some_profile.id}"
lifecycle {
create_before_destroy = true
}
tags = {
"Name" = "EC2Private"
}
}