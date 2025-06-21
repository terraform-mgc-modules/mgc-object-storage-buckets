# Guia de Configuração da API Key - MGC Provider

## Problema: "api-key not set"

Este erro indica que o provider MGC não está recebendo a API key corretamente. Existem várias formas de configurar:

### Método 1: Variável de Ambiente (Recomendado)
```bash
export MGC_API_KEY="sua-api-key-aqui"
terraform plan
terraform apply
```

### Método 2: Arquivo terraform.tfvars
```hcl
mgc_api_key = "sua-api-key-aqui"
```

### Método 3: Via linha de comando
```bash
terraform plan -var="mgc_api_key=sua-api-key-aqui"
terraform apply -var="mgc_api_key=sua-api-key-aqui"
```

### Método 4: CLI do MGC
Se você tem o CLI do MGC instalado, configure primeiro:
```bash
mgc auth login
# ou
mgc object-storage api-key set "sua-api-key-aqui"
```

### Verificação da Configuração

Para verificar se a configuração está correta:

1. **Verifique se a API key está no formato correto (UUID)**
   ```
   Formato: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   ```

2. **Teste com variável de ambiente:**
   ```bash
   export MGC_API_KEY="15fee17d-6a6f-44a5-a70a-d44b2758d156"
   terraform plan
   ```

3. **Verifique os logs do Terraform:**
   ```bash
   TF_LOG=DEBUG terraform plan
   ```

### Troubleshooting

- ✅ A API key deve ser válida e ativa
- ✅ A API key deve ter permissões para object storage
- ✅ Verifique se não há espaços em branco na API key
- ✅ Teste primeiro com o CLI do MGC para validar credenciais

### Exemplo Funcional

```bash
# 1. Configure a variável de ambiente
export MGC_API_KEY="sua-api-key-aqui"

# 2. Configure região (opcional)
export MGC_REGION="br-se1"

# 3. Execute o Terraform
terraform init
terraform plan
terraform apply
```

### Configuração do Provider Alternativa

Se ainda houver problemas, tente esta configuração no `versions.tf`:

```hcl
provider "mgc" {
  # API key será lida automaticamente da variável de ambiente MGC_API_KEY
  # ou do arquivo de configuração do CLI mgc
  region = var.mgc_region
}
```
