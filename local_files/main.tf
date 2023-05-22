resource "local_file" "userdata" {
    content = <<EOF
#!/bin/bash
apt update -y
apt install -y apache2
systemctl start apache2
systemctl enable apache2
EOF
    filename = "userdata.sh"
}

resource "local_file" "nginx_proxy" {
    content = <<EOF
#!/bin/bash
sudo apt update -y
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo unlink /etc/nginx/sites-enabled/default
sudo sh -c 'echo "server {
  listen 80;
  location / {
    proxy_pass http://${var.private_lb_dns};
  }
}" > /etc/nginx/sites-enabled/proxy.conf'
sudo systemctl restart nginx
EOF
    filename = "nginx_proxy.sh"
}