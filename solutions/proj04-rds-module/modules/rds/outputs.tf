output "rds_instance_id" {
  value = aws_db_instance.this.id
}

output "rds_instance_endpoint" {
  value = aws_db_instance.this.endpoint
}
