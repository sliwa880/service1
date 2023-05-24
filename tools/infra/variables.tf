variable "environment" {
}

variable "image_repository" {
  description = "The image repository name used in Container App"
}

variable "image_tag" {
  description = "The image tag used in Container App"
}

variable "resources" {
  type = object({
    cpu    = number # 0.25
    memory = string # "0.5Gi"
  })
}

variable "uksouth_scale" {
  type = object({
    minReplicas = number # 1
    maxReplicas = number # 1
  })
}
