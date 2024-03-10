resource "null_resource" "processospowershell" {
  provisioner "local-exec" {
    command     = "Get-Process > processos.txt"
    interpreter = ["Powershell", "-Command"]
  }
}