locals {
  subnet_peering_combination = {
    for pair in flatten([
      for subnet_key, subnet_val in aws_subnet.main : [
        for peer_key, peer_val in aws_vpc_peering_connection.main : {
          key = "${subnet_key}-${peer_key}"
          value = {
            az = subnet_val.id
            id = peer_val.id
          }
        }
      ]
    ]) :
    pair.key => pair.value
  }
}

output "subnet_peering_combination" {
  value = local.subnet_peering_combination
}

