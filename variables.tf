variable "model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = ""
}

variable "channel" {
  description = "The channel to use when deploying a charm."
  type        = string
  default     = "1.3/edge"
}

variable "external_hostname" {
  description = "The DNS name to be used by Traefik ingress."
  type        = string
  default     = ""
}

variable "db_application_name" {
  description = "The name of the application providing the `database` endpoint."
  type        = string
  default     = "mongodb-k8s"
}

variable "certs_application_name" {
  description = "Name of the application providing the `certificates` integration endpoint."
  type = string
  default = "self-signed-certificates"
}

variable "nrf_application_name" {
  description = "The name of the application providing the `fiveg_nrf` endpoint."
  type        = string
  default     = "nrf"
}

variable "amf_application_name" {
  description = "The name of the application."
  type        = string
  default     = "amf"
}

variable "traefik_application_name" {
  description = "Name of the application"
  type = string
  default = "traefik-k8s"
}

variable "webui_application_name" {
  description = "The name of the application."
  type        = string
  default     = "webui"
}

variable "gnb_application_name" {
  description = "The name of the application."
  type        = string
  default     = "gnb"
}
