terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "2.4.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

resource "random_string" "nome_arquivo" {
  length  = 5
  special = false
  numeric = false
  lower   = true
  upper   = false
}

data "archive_file" "random_name" {
  type        = "zip"
  source_file = "${path.module}/files/arquivo.txt"
  output_path = "${path.module}/backup/backup_${random_string.nome_arquivo.result}.zip"
}

output "saida_archive" {
  value = data.archive_file.random_name.output_size
}

output "saida_random_string" {
  value = random_string.nome_arquivo.result
}