locals {
  ssh_key_pair_name = "ssh-${var.region}"
  self_ip           = chomp(data.http.myip.response_body)
  firewall_rules = {
    22 = ["${local.self_ip}/32"]
    80 = ["0.0.0.0/0"]
  }
}
