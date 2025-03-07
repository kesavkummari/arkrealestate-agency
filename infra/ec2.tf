terraform {
  backend "s3" {
    bucket = "9281430306"
    key    = "tf-statefiles/ark-terraform.tfstate"
    region = "ap-south-2"
  }
}
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_id
  subnet_id              = var.subnet_id
  user_data              = file("install.sh")
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name    = var.instance_name
    Created = var.createdby
  }
}
