variable "project_name" {
  type = string
}

variable "instance_class" {
  type = string

  validation {
    condition     = contains(["db.t3.micro"], var.instance_class)
    error_message = "Only db.t3.micro is allowed due to free tier limitations"
  }
}

variable "storage_size" {
  type = number

  validation {
    condition     = var.storage_size > 1 && var.storage_size < 5
    error_message = "Please specify DB storage between 1 and 5 GB"
  }
}

variable "engine" {
  type = string

  validation {
    condition     = contains(["mysql", "postgres-latest", "postgres-14"], var.engine)
    error_message = "Only mysql, postgres-latest and postgres-14 are allowed"
  }
}

variable "credentials" {
  type = object({
    username = string,
    password = string
  })

  sensitive = true

  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.credentials.password)) > 0 &&
      length(regexall("[0-9]+", var.credentials.password)) > 0 &&
      length(regexall("[a-zA-Z0-9]{8,0}", var.credentials.password)) > 0
    )
    error_message = <<-EOT
        Password must comply following rules:
        1. Contain at least 1 character
        2. Contain at least 1 digit
        3. Must be at least 8 characters logn
    EOT
  }
}
