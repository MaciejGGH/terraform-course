variable "allowed_ip_ranges" {
  type        = list(string)
  description = "List of IP ranges allowed to access the RDS instance"
  default     = [""]  # Replace with your IP ranges
}