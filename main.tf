resource "juju_application" "nms" {
  name = "nms"
  model = var.model_name

  charm {
    name = "sdcore-nms-k8s"
    channel = var.channel
  }

  units = 1
  trust = true
}

module "mongodb-k8s" {
  source     = "gatici/mongodb-k8s/juju"
  model_name = var.model_name
}

module "self-signed-certificates" {
  source     = "gatici/self-signed-certificates/juju"
  model_name = var.model_name
}

module "sdcore-nrf-k8s" {
  source  = "gatici/sdcore-nrf-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
}

module "sdcore-amf-k8s" {
  source  = "gatici/sdcore-amf-k8s/juju"
  model_name = var.model_name
  certs_application_name = var.certs_application_name
  db_application_name = var.db_application_name
  channel = var.channel
  nrf_application_name = var.nrf_application_name
}

module "traefik-k8s" {
  source  = "gatici/traefik-k8s/juju"
  model_name = var.model_name
}

module "sdcore-webui-k8s" {
  source  = "gatici/sdcore-webui-k8s/juju"
  model_name = var.model_name
  db_application_name = var.db_application_name
  channel = var.channel
}

# module "sdcore-gnbsim-k8s" {
#   source  = "gatici/sdcore-gnbsim-k8s/juju"
#   version = "1.0.0"
#   amf_application_name = var.amf_application_name
#   channel = var.channel
# }

resource "juju_integration" "nms-traefik" {
  model = var.model_name

  application {
    name     = juju_application.nms.name
    endpoint = "ingress"
  }

  application {
    name     = var.traefik_application_name
    endpoint = "ingress"
  }
}

resource "juju_integration" "nms-webui" {
  model = var.model_name

  application {
    name     = juju_application.nms.name
    endpoint = "sdcore-management"
  }

  application {
    name     = var.webui_application_name
    endpoint = "sdcore-management"
  }
}

# resource "juju_integration" "nms-gnb" {
#   model = var.model_name
#
#   application {
#     name     = juju_application.nms.name
#     endpoint = "fiveg_gnb_identity"
#   }
#
#   application {
#     name     = var.gnb_application_name
#     endpoint = "fiveg_gnb_identity"
#   }
# }

