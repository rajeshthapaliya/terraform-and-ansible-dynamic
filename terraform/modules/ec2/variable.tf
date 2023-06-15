variable "ami" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "instance_count" {
  type    = number
  default = 3
}

variable "subnet_id" {
 default = ""
}

variable "security_group" {
  default = ""
}

variable "key_name" {
  default = ""
}