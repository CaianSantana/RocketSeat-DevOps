module "s3" {
  source      = "./modules/s3"
  org_name    = "ifba"
  bucket_name = "bucket-terraform"
  s3_tags = {
    IaC = true
  }
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  origin_id          = module.s3.bucket_id
  bucket_domain_name = module.s3.bucket_domain_name
  cdn_tags = {
    IaC = true
  }

  depends_on = [module.s3]
}