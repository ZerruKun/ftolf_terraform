variable "cloud_id" {
  description = "Идентификатор облака"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор каталога"
  type        = string
}

variable "zone" {
  description = "Зона размещения ресурсов"
  type        = string
  default     = "ru-central1-d"
}
