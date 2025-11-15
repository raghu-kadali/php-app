variable "project_id" {
  type        = string
  default     = "kubernetes-477004"
}

variable "region" {
  type        = string
  default     = "us-central1"
}

variable "zone" {
  type        = string
  default     = "us-central1-a"
}

variable "docker_image" {
  type        = string
  default     = "us-central1-docker.pkg.dev/raghu2pm/php-app-repo/php-app:latest"
}

