terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "2.4.2"
    }
  }
}

# data "archive_file" "arquivo_zip" {
#   type        = "zip"
#   source_file = "${path.module}/files/dados.txt"
#   output_path = "${path.module}/backup/dados.zip"
# }

# output "saida_archive" {
#   value = data.archive_file.arquivo_zip.output_size
# }

data "archive_file" "folder_zip" {
  type        = "zip"
  source_dir  = "${path.module}/files"
  output_path = "${path.module}/backup/backup_files.zip"
}

output "saida_archive" {
  value = data.archive_file.folder_zip.output_size
}