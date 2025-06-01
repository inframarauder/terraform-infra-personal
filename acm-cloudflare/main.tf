# Create ACM Cert
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = var.domain_name
  zone_id     = data.cloudflare_zones.this.result[0].id

  # allow wildcard certificates
  subject_alternative_names = [
    "*.${var.domain_name}",
  ]

  create_route53_records  = false
  validation_method       = "DNS"
  validation_record_fqdns = cloudflare_dns_record.validation[*].name

  tags = {
    Name = var.domain_name
  }
}

# fetch the Cloudflare zone ID
data "cloudflare_zones" "this" {
  name = var.domain_name
}

# Create DNS records for ACM validation
resource "cloudflare_dns_record" "validation" {
  count = length(module.acm.distinct_domain_names)

  zone_id = data.cloudflare_zones.this.result[0].id
  name    = element(module.acm.validation_domains, count.index)["resource_record_name"]
  type    = element(module.acm.validation_domains, count.index)["resource_record_type"]
  content = trimsuffix(element(module.acm.validation_domains, count.index)["resource_record_value"], ".")
  ttl     = 60
  proxied = false
}
