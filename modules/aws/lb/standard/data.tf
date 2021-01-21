module "lb_security_groups" {
  source = "../../lookups/security_groups"

  names  = var.security_group_names
  vpc_id = var.vpc_id

  module_depends_on = var.module_depends_on
}
