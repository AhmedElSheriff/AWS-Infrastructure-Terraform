output "apache2" {
    value = local_file.userdata.content
}

output "nginx_proxy" {
    value = local_file.nginx_proxy.filename
}