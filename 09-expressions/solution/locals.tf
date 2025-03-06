locals {
  math       = 2 * 2
  equality   = 2 != 2
  comparison = 2 < 1
  logical    = true || false
}
locals {
  double_numbers = [for num in var.numbers_list : num * 2]
  even_numbers   = [for num in var.numbers_list : num if num % 2 == 0]
  firstnames     = [for person in var.objects_list : person.firstname]
  fullnames = [
    for person in var.objects_list : "${person.firstname} ${person.lastname}"
  ]
}
locals {
  doubles_map = { for key, value in var.numbers_map : key => value * 2 }
  even_map = { for key, value in var.numbers_map : key =>
    value if value % 2 == 0
  }
}