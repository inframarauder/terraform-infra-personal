apiVersion: eks.amazonaws.com/v1
kind: NodeClass
metadata:
  name: ${node_class_name}
spec:
  role: ${node_role_arn}
  subnetSelectorTerms: 
  %{ for id in subnet_ids ~}
      - id: ${id}
  %{ endfor ~}
  securityGroupSelectorTerms: 
  %{ for id in security_group_ids ~}
      - id: ${id}
  %{ endfor ~}
  ephemeralStorage:
    size: ${ephemeral_storage_size}