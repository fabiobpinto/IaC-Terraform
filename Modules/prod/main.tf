module "prod" {
  source   = "../infra"
  location = "eastus"
  ambiente = "PROD"
}

