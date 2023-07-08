# Секреты
# variable "database_name" {
#   description = "Наименование базы данных"
#   type        = string
#   sensitive = true
# }
# variable "database_user" {
#   description = "Пользователь базы данных"
#   type        = string
#   sensitive = true
# }
# variable "database_user_password" {
#   description = "Пароль пользователя базы данных"
#   type        = string
#   sensitive = true
# }
variable "pvt_key" {
  type        = string
  description = "Приватный ключ"
  sensitive   = true
  default = "/home/dobro/.ssh/hexlet_do"
}
variable "do_token" {
  type        = string
  description = "Токен DigitalOcean"
  sensitive   = true
}

# Переменные
variable "ubuntu_image" {
  description = "Версия Убунты"
  type        = string
  default     = "ubuntu-22-10-x64"
}
variable "signapore_region" {
  description = "Значение Сингапурского региона в DigitalOcean"
  type        = string
  default     = "sgp1"
  sensitive = true
}
variable "size" {
  description = "Параметры дроплета"
  type        = string
  default     = "s-2vcpu-2gb"
}
