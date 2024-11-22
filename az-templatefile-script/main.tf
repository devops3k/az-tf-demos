resource "local_file" "script" {
  filename = "${path.module}/script.sh"
  content  = templatefile("${path.module}/installweb.tftpl", {
    app_prefix = "helloHello"
  })
}