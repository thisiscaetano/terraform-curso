variable "int_type" {
  description = "tipo da instancia"
  default     = "t2.micro"
}

variable "disable_api_termination" {
  description = "proteção de termino da instancia"
  default     = false
}

variable "int_name" {
  description = "lista de nomes para instancias"
  type        = list(string)
  default     = ["server-1", "server-2", "server-3-import"]
}

variable "region" {
  description = "Regiao"
  default     = "us-east-1"
}

variable "amis" {
  description = "Amis para determinadas regioes"
  type        = map(any)
  default = {
    "us-east-1" = "ami-09d3b3274b6c5d4aa"
    "us-east-2" = "ami-04897acca32efd05c"
  }

}