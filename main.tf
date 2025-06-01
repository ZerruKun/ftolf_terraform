terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.142.0"
    }
  }
  required_version = ">= 0.14"
  backend "local" {}
}

provider "yandex" {
  service_account_key_file = "config/authorized_key.json"
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

# Создание VPC
resource "yandex_vpc_network" "default" {
  name = "little-fox-net"
}

# Создание подсети
resource "yandex_vpc_subnet" "default" {
  name           = "little-fox-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# Создание ВМ
resource "yandex_compute_instance" "little-fox" {
  name        = "little-fox"
  hostname    = "little-fox"
  zone        = var.zone
  platform_id = "standard-v2"

  scheduling_policy {
    preemptible = true
  }

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd80ovuibhi56app54sj"
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    user-data = file("config/init.yaml")
  }
}
