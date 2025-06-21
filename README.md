# Módulo Terraform - Magalu Cloud Object Storage Buckets

Este módulo Terraform permite criar e gerenciar buckets de object storage na Magalu Cloud de forma simples e segura.

## Funcionalidades

- 🪣 **Criação de buckets** com configurações personalizáveis
- 🔐 **Controle de acesso** com diferentes níveis de permissão
- 📝 **Versionamento** opcional para controle de versões de objetos
- 🏷️ **Nomes únicos** com opção de usar prefixo automaticamente
- 🔍 **Data sources** para consultar informações dos buckets
- 📊 **Outputs detalhados** com informações do bucket criado

## Uso

### Exemplo Básico

```hcl
module "my_bucket" {
  source = "./mgc-object-storage-buckets"
  
  bucket_name       = "meu-bucket-exemplo"
  enable_versioning = true
  private           = true
}
```

### Exemplo com Nome como Prefixo

```hcl
module "unique_bucket" {
  source = "./mgc-object-storage-buckets"
  
  bucket_name      = "meu-prefixo"
  bucket_is_prefix = true
  enable_versioning = true
}
```

### Exemplo de Bucket Público

```hcl
module "public_bucket" {
  source = "./mgc-object-storage-buckets"
  
  bucket_name = "bucket-publico"
  public_read = true
}
```

## Variáveis de Entrada

| Nome                 | Descrição                                                 | Tipo     | Padrão     | Obrigatório |
| -------------------- | --------------------------------------------------------- | -------- | ---------- | ----------- |
| `mgc_api_key`        | API Key da Magalu Cloud                                   | `string` | -          | ✅           |
| `mgc_region`         | Região da Magalu Cloud                                    | `string` | `"br-se1"` | ❌           |
| `bucket_name`        | Nome do bucket a ser criado                               | `string` | -          | ✅           |
| `bucket_is_prefix`   | Usar nome como prefixo para gerar nome único              | `bool`   | `false`    | ❌           |
| `enable_versioning`  | Habilitar versionamento                                   | `bool`   | `false`    | ❌           |
| `authenticated_read` | Acesso de leitura para usuários autenticados              | `bool`   | `false`    | ❌           |
| `aws_exec_read`      | Habilitar aws_exec_read                                   | `bool`   | `false`    | ❌           |
| `private`            | Bucket privado (apenas proprietário e usuários delegados) | `bool`   | `true`     | ❌           |
| `public_read`        | Acesso público de leitura                                 | `bool`   | `false`    | ❌           |
| `public_read_write`  | Acesso público de leitura e escrita                       | `bool`   | `false`    | ❌           |
| `recursive`          | Deletar bucket incluindo objetos internos                 | `bool`   | `false`    | ❌           |

## Outputs

| Nome                        | Descrição                                              |
| --------------------------- | ------------------------------------------------------ |
| `bucket_name`               | Nome do bucket criado                                  |
| `bucket_final_name`         | Nome final do bucket (com prefixo/sufixo se aplicável) |
| `bucket_versioning_enabled` | Status do versionamento                                |
| `bucket_id`                 | ID do recurso do bucket                                |
| `bucket_details`            | Detalhes completos do bucket                           |
| `bucket_versioning_status`  | Status detalhado do versionamento                      |
| `bucket_access_policy`      | Política de acesso do bucket                           |

## Configuração de ACL

⚠️ **Importante:** Apenas uma das opções de ACL deve ser definida como `true`:

- `private` (padrão): Apenas proprietário e usuários delegados têm acesso
- `public_read`: Acesso público de leitura
- `public_read_write`: Acesso público de leitura e escrita
- `authenticated_read`: Usuários autenticados têm acesso de leitura

## Arquivo terraform.tfvars

Crie um arquivo `terraform.tfvars` com suas configurações:

```hcl
mgc_api_key = "sua-api-key-aqui"
mgc_region  = "br-se1"

bucket_name       = "meu-bucket"
enable_versioning = true
private           = true
```

## Pré-requisitos

- Terraform >= 1.0
- Provider MGC >= 0.33.0
- API Key válida da Magalu Cloud

## Segurança

Este módulo segue as melhores práticas de segurança:

- ✅ API Key é marcada como `sensitive`
- ✅ Validação de nome de bucket conforme padrões
- ✅ Configuração padrão como bucket privado
- ✅ Integração com workflows de segurança (Checkov, Trivy, etc.)

## Exemplos Adicionais

Consulte o arquivo `examples.tf` para mais exemplos de configuração.

## Contribuindo

1. Fork este repositório
2. Crie uma branch para sua feature
3. Faça commit das mudanças
4. Abra um Pull Request

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

---

Feito com ❤️ por [Natália Granato](https://github.com/nataliagranato)
