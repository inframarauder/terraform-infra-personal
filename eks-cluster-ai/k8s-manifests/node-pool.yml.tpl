apiVersion: karpenter.sh/v1
kind: NodePool
metadata:
  name: ${node_pool_name}
spec:
  template:
    spec:
      nodeClassRef:
        group: eks.amazonaws.com
        kind: NodeClass
        name: ${node_class_name}

      requirements:
        - key: "eks.amazonaws.com/instance-family"
          operator: In
          values: ${jsonencode(instance_families)}
        - key: "eks.amazonaws.com/instance-size"
          operator: In
          values: ${jsonencode(instance_sizes)}
        - key: "topology.kubernetes.io/zone"
          operator: In
          values: ${jsonencode(availability_zones)}
        - key: "karpenter.sh/capacity-type"
          operator: In
          values: ${jsonencode(capacity_types)}

  limits:
    cpu: "1000"
    memory: 1000Gi