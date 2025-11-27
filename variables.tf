variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "my_ip" {
  type    = string
  default = "0.0.0.0/0" # เปลี่ยนตอนรันเป็น <your_ip>/32 เช่น 203.0.113.5/32
}
