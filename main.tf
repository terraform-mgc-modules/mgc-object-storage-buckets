resource "mgc_object_storage_buckets" "this" {
  bucket             = var.bucket_name
  bucket_is_prefix   = var.bucket_is_prefix
  enable_versioning  = var.enable_versioning
  authenticated_read = var.authenticated_read
  aws_exec_read      = var.aws_exec_read
  private            = var.private
  public_read        = var.public_read
  public_read_write  = var.public_read_write
  recursive          = var.recursive

  lifecycle {
    precondition {
      condition     = length([for v in [var.private, var.public_read, var.public_read_write, var.authenticated_read] : v if v]) == 1
      error_message = "Exactly one of 'private', 'public_read', 'public_read_write', or 'authenticated_read' must be set to true."
    }
  }
}

# Data source para consultar detalhes do bucket criado
data "mgc_object_storage_bucket" "this" {
  name = mgc_object_storage_buckets.this.final_name

  depends_on = [mgc_object_storage_buckets.this]
}
