# Documentação Técnica - MGC Object Storage Buckets Module

## Arquitetura do Módulo

Este módulo Terraform foi projetado para ser simples, reutilizável e seguir as melhores práticas de IaC (Infrastructure as Code).

### Estrutura de Arquivos

```
mgc-object-storage-buckets/
├── main.tf              # Recursos principais
├── variables.tf         # Definições de variáveis
├── outputs.tf          # Definições de outputs
├── versions.tf         # Configuração de providers
├── terraform.tfvars    # Exemplo de valores
├── examples.tf         # Exemplos comentados
├── usage-example.tf    # Exemplo de uso como módulo
├── README.md           # Documentação principal
└── TECHNICAL.md        # Este arquivo
```

## Recursos Criados

### 1. mgc_object_storage_buckets (Resource)
- **Finalidade:** Cria o bucket de object storage
- **Parâmetros principais:**
  - `bucket`: Nome do bucket
  - `bucket_is_prefix`: Se true, gera nome único usando o valor como prefixo
  - `enable_versioning`: Habilita versionamento
  - ACL: `private`, `public_read`, `public_read_write`, `authenticated_read`

### 2. mgc_object_storage_bucket (Data Source)
- **Finalidade:** Consulta detalhes do bucket criado
- **Dependência:** Aguarda criação do resource `mgc_object_storage_buckets`
- **Informações retornadas:** versioning, policy, mfadelete

## Configurações de ACL

O módulo suporta 4 tipos de configuração de acesso:

| Configuração         | Proprietário | Usuários Autenticados | Público    |
| -------------------- | ------------ | --------------------- | ---------- |
| `private` (padrão)   | FULL_CONTROL | Delegados apenas      | Sem acesso |
| `authenticated_read` | FULL_CONTROL | READ                  | Sem acesso |
| `public_read`        | FULL_CONTROL | -                     | READ       |
| `public_read_write`  | FULL_CONTROL | -                     | READ/WRITE |

⚠️ **Importante:** Apenas uma configuração de ACL deve ser `true` por vez.

## Validações

### Nome do Bucket
```hcl
validation {
  condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
  error_message = "O nome do bucket deve ter entre 3 e 63 caracteres e conter apenas letras minúsculas, números, pontos e hífens."
}
```

## Outputs Detalhados

### Outputs do Resource
- `bucket_name`: Nome original fornecido
- `bucket_final_name`: Nome final (importante quando `bucket_is_prefix = true`)
- `bucket_versioning_enabled`: Boolean do versionamento
- `bucket_id`: ID único do recurso

### Outputs do Data Source
- `bucket_details`: Objeto completo com todas as informações
- `bucket_versioning_status`: Status detalhado do versionamento
- `bucket_access_policy`: Política de acesso atual

## Boas Práticas Implementadas

### 1. Segurança
- API Key marcada como `sensitive`
- Configuração padrão como bucket privado
- Validação de entrada para nomes de bucket

### 2. Flexibilidade
- Variáveis opcionais com valores padrão sensatos
- Suporte a diferentes configurações de ACL
- Opção de nome único automático

### 3. Observabilidade
- Outputs detalhados para integração
- Data source para consulta de estado
- Documentação completa

## Casos de Uso Comuns

### 1. Desenvolvimento
```hcl
module "dev_bucket" {
  source = "./mgc-object-storage-buckets"
  
  bucket_name      = "app-dev"
  bucket_is_prefix = true
  private          = true
}
```

### 2. Staging
```hcl
module "staging_bucket" {
  source = "./mgc-object-storage-buckets"
  
  bucket_name       = "app-staging"
  enable_versioning = true
  private           = true
}
```

### 3. Produção
```hcl
module "prod_bucket" {
  source = "./mgc-object-storage-buckets"
  
  bucket_name       = "app-production"
  enable_versioning = true
  private           = true
}
```

### 4. Bucket Público (Website)
```hcl
module "website_bucket" {
  source = "./mgc-object-storage-buckets"
  
  bucket_name = "meu-website"
  public_read = true
}
```

## Integração com CI/CD

### GitHub Actions
O módulo é compatível com pipelines automatizados:

```yaml
- name: Terraform Plan
  run: |
    terraform plan -var="mgc_api_key=${{ secrets.MGC_API_KEY }}"
    
- name: Terraform Apply
  run: |
    terraform apply -auto-approve -var="mgc_api_key=${{ secrets.MGC_API_KEY }}"
```

### Variáveis de Ambiente
```bash
export TF_VAR_mgc_api_key="sua-api-key"
export TF_VAR_mgc_region="br-se1"
```

## Limitações Conhecidas

1. **Grant Permissions:** Os grants não são implementados como blocos dinâmicos devido a limitações do provider
2. **Região:** O parâmetro `region` não é suportado no resource, apenas no provider
3. **ACL Mutual Exclusive:** Apenas uma configuração de ACL pode ser ativa

## Roadmap

- [ ] Implementação de grants quando suportado pelo provider
- [ ] Suporte a múltiplas regiões
- [ ] Integração com lifecycle policies
- [ ] Suporte a server-side encryption

## Troubleshooting

### Erro: "bucket name already exists"
**Solução:** Use `bucket_is_prefix = true` para gerar nome único

### Erro: "invalid bucket name"
**Solução:** Verifique se o nome atende aos critérios da validação

### Erro: "permission denied"
**Solução:** Verifique se a API Key tem permissões adequadas

## Contribuindo

Para contribuir com melhorias:

1. Teste localmente com `terraform validate`
2. Execute `terraform fmt` para formatação
3. Atualize documentação se necessário
4. Submeta PR com descrição detalhada
