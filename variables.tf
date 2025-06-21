variable "mgc_api_key" {
  description = "API Key da Magalu Cloud"
  type        = string
}

variable "mgc_region" {
  description = "Região da Magalu Cloud (ex: br-se1)"
  type        = string
  default     = "br-se1"
}

variable "bucket_name" {
  description = "Nome do bucket a ser criado"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "O nome do bucket deve ter entre 3 e 63 caracteres e conter apenas letras minúsculas, números, pontos e hífens."
  }
}

variable "bucket_is_prefix" {
  description = "Usar o nome do bucket como prefixo para gerar um nome único"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Habilitar versionamento para este bucket"
  type        = bool
  default     = false
}

variable "authenticated_read" {
  description = "Proprietário obtém FULL_CONTROL. Usuários autenticados têm direitos de READ"
  type        = bool
  default     = false
}

variable "aws_exec_read" {
  description = "Habilitar aws_exec_read"
  type        = bool
  default     = false
}

variable "private" {
  description = "Proprietário obtém FULL_CONTROL. Usuários delegados têm acesso. Ninguém mais tem direitos de acesso"
  type        = bool
  default     = true
}

variable "public_read" {
  description = "Proprietário obtém FULL_CONTROL. Todos os outros têm direitos de READ"
  type        = bool
  default     = false
}

variable "public_read_write" {
  description = "Proprietário obtém FULL_CONTROL. Todos os outros têm direitos de READ e WRITE"
  type        = bool
  default     = false
}

variable "recursive" {
  description = "Deletar bucket incluindo objetos internos"
  type        = bool
  default     = false
}
