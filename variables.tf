# Kestra variables
variable "username" {
  description = "User name of the Kestra instance"
  type        = string
  sensitive   = true
}

variable "password" {
  description = "Password of the Kestra instance"
  type        = string
  sensitive   = true
}

variable "hostname" {
  description = "Hostname of the Kestra instance"
  type        = string
}

variable "github_access_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}
