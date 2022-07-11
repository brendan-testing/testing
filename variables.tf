variable "release_version" {
  description = "The version of the app to deploy"
}

variable "product" {
  default = "infra"
}

variable "service" {
  default = "security-monitor"
}

variable "environment" {
  default = "prod"
}

variable "owner" {
  default = "Brendan Geraghty"
}


variable "pagerduty_rotation" {
  default = "operations"
}
