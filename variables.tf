variable "vpc_cidr" {
  default = "10.0.0.0/16"
}


variable "public_cidr" {
  default = [
    "10.0.10.0/24",
    "10.0.16.0/24"
  ]

}

variable "privat_cidr" {
  default = [
    "10.0.11.0/24",
    "10.0.17.0/24"
  ]
}
