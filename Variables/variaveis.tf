variable "namerg" {
  default = "Terraform"
}

variable "location" {
  type        = string
  description = "Localização do Recurso"
  default     = "brazilsouth"
}

variable "tags" {
  type        = map(any)
  description = "Tags dos Recursos e Serviços"
  default = {
    Env         = "QAS"
    Software    = "Terraform"
    Engineering = "Fabio Brito"
  }
}

variable "address_space" {
  type        = list(any)
  description = "Ranges de Redes"
  default     = ["10.0.0.0/16", "192.168.0.0/16"]
}