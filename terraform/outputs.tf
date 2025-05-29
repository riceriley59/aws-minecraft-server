output "minecraft_server_ip" {
  value = aws_instance.minecraft-server.public_ip
}

output "minecraft_server_dns" {
  value = aws_instance.minecraft-server.public_dns
}
