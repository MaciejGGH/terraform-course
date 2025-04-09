output "rds_instance_id" {
  value = aws_db_instance.this.id
}

output "rds_instance_endpoint" {
  value = aws_db_instance.this.endpoint
}

output "rds_instance_address" {
  value = aws_db_instance.this.address
}

output "rds_instance_port" {
  value = aws_db_instance.this.port
}
