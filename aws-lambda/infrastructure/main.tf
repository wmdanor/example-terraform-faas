
variable "prefix" {
  type = string
}

module "uppercaser" {
  source = "./modules/lambda"

  function_name = "${var.prefix}uppercaser"
}

module "lowercaser" {
  source = "./modules/lambda"

  function_name = "${var.prefix}lowercaser"
}
