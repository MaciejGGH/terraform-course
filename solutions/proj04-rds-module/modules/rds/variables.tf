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

variable "storage_type" {
  type        = string
  default     = "standard"
  description = "Storage type to be used for the DB instance. Only standard is allowed due to free tier limitations"

  validation {
    condition     = contains(["standard"], var.storage_type)
    error_message = "Only standard is allowed due to free tier limitations"
  }
}

variable "storage_size" {
  type        = number
  default     = 5
  description = <<-EOT
  Amount of storage in GB to be used for the DB instance. Must be between 5 and 3072 GB in case of standart storage type (magnetic).
  https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html#API_CreateDBInstance_RequestParameters
  EOT

  validation {
    condition     = var.storage_size >= 5 && var.storage_size <= 50
    error_message = "Please specify DB storage between 20 and 50 GB to comply with free tier limitations."
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