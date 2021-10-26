source "amazon-ebs" "linux" {

//   assume_role {
//     role_arn     = "arn:aws:iam::229179723177:role/OrganizationAccountAccessRole"
//     session_name = "packer"
//   }

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-ebs"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]

  }

  ami_name      = local.ami_name
  instance_type = var.instance_type
  region        = var.region
  subnet_id     = var.subnet_id
  vpc_id        = var.vpc_id



  # connection parameters
  communicator                 = var.communicator
  ssh_username                 = var.ssh_username

  ssh_interface        = "session_manager"
  iam_instance_profile = "packer"

  tags = {
    Environment     = var.env
    Name            = local.ami_name
    PackerBuilt     = "true"
    PackerTimestamp = local.timestamp
    Service         = var.service
  }
}
