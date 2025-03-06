variable "numbers_list" {
  type    = list(number)
  default = [1, 2, 3, 4]
}

variable "objects_list" {
  type = list(object({
    firstname = string
    lastname  = string
  }))
  default = [{
    firstname = "John"
    lastname  = "Doe"
    }, {
    firstname = "Jane"
    lastname  = "Doe"
  }]
}

variable "numbers_map" {
  type = map(number)
  default = {
    "one"   = 1
    "two"   = 2
    "three" = 3
    "four"  = 4
    "five"  = 5
    "six"   = 6
    "seven" = 7
    "eight" = 8
    "nine"  = 9
    "ten"   = 10
  }
}

    