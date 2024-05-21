# variables.tf
variable "commit_sha" {
  description = "The short commit SHA for tagging the Docker image"
  type        = string
}

variable "port" {
    description = "The port number for the web application"
    type        = number
}