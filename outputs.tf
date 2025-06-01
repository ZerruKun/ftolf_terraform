output "instance_ip" {
  value = yandex_compute_instance.little-fox.network_interface[0].nat_ip_address
}
