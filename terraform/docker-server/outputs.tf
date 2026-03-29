output "docker_server_public_ip" {
  description = "Public IP of the Docker build server"
  value       = aws_instance.docker_server.public_ip
}

output "docker_server_public_dns" {
  description = "Public DNS of the Docker build server"
  value       = aws_instance.docker_server.public_dns
}