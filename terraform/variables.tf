variable "ubuntu_image" {
  description = "Версия Убунты"
  type        = string
  default     = "ubuntu-22-10-x64"
}
variable "signapore_region" {
  description = "Значение Сингапурского региона в DigitalOcean"
  type        = string
  default     = "sgp1"
}
variable "size" {
  description = "Параметры дроплета"
  type        = string
  default     = "s-2vcpu-2gb"
}
