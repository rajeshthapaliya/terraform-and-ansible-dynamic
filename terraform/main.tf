module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = "10.0.0.0/16"
  abcsubnet = "10.0.1.0/24"
}

module "ec2" {
  source         = "./modules/ec2"
  ami            = "ami-053b0d53c279acc90"
  instance_type  = "t2.micro"
  instance_count = 2
  key_name       = "5822_authkey_Rajesh"
  subnet_id      = module.vpc.abcsubnet
  security_group = module.vpc.abcsg
}