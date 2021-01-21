locals {
  vpc_name             = "${var.vpc_id} ${upper(data.aws_region.current.name)}"
  intranet_cidr_blocks = length(var.intranet_cidr_blocks) > 0 ? var.intranet_cidr_blocks : [data.aws_vpc.main.cidr_block_associations[0].cidr_block]

  allowed_groups = {
    HTTP = {
      public = true
      ports  = [80, 443]
    }

    PostgreSQL = {
      ports = [5432]
    }

    MySQL = {
      ports = [3306]
    }
  }

  groups = {
    for k, v in local.allowed_groups :
    k => v if contains(var.groups, k)
  }

  group_ports = flatten([
    for name, def in local.groups : [
      for port in def.ports : {
        key    = "${name}-${port}"
        port   = port
        public = lookup(def, "public", false)
        name   = name
      }
    ]
  ])
}