#####################
# General information
#####################

variable "project_name" {
  type        = string
  description = "Project name to be used in all resources"
}

#####################
# DB configuration
#####################

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Instance class to be used for the DB instance. Only db.t3.micro is allowed due to free tier limitations"

  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is allowed due to free tier limitations"
  }
}

variable "storage_size" {
  type        = number
  default     = 2
  description = "Amount of storage in GB to be used for the DB instance. Only 2, 3 and 4 are allowed due to free tier limitations"

  validation {
    condition     = var.storage_size > 1 && var.storage_size < 5
    error_message = "Please specify DB storage between 1 and 5 GB"
  }
}

variable "engine" {
  type        = string
  default     = "mysql"
  description = "DB engine to be used for the DB instance. Only mysql, postgres-latest and postgres-14 are allowed"

  validation {
    condition     = contains(["mysql", "postgres-latest", "postgres-14"], var.engine)
    error_message = "Only mysql, postgres-latest and postgres-14 are allowed"
  }
}

#####################
# DB credentials
#####################

variable "credentials" {
  type = object({
    username = string,
    password = string
  })

  sensitive   = true
  description = "root Username and password to be used for the DB instance."

  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.credentials.password)) > 0 &&
      length(regexall("[0-9]+", var.credentials.password)) > 0 &&
      length(regexall("^[a-zA-Z0-9+-_?!]{8,}$", var.credentials.password)) > 0 &&
      length(var.credentials.password) > 8
    )
    error_message = <<-EOT
        Password must comply following rules:
        1. Contain at least 1 character
        2. Contain at least 1 digit
        3. Must be at least 8 characters long
        4. Can contain only alphanumeric characters, +, -, _, ?, !
        5. Cannot contain spaces
    EOT
  }
}

#####################
# DB Network
#####################

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to be used for the DB instance."
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to be attached to the DB instance."

}