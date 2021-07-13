# Resolução - Challenge Getmore-Api Team
Para execultar este projeto, é necessário ter instalado o [Docker](https://docker.com/get-started) e o [Docker Compose](https://docs.docker.com/compose/install/).
## Instação
```bash
docker-compose build
```
## Iniciar
```bash
docker-compose up -d
```
## Uso
A aplicação api, disponibiliza um endpoint que pode ser acessado através de `http://localhost:4000`
### Rota
- `GET /api/products` - Retorna uma lista dos produtos cadastrados

  Parâmetros:
  - `page_size` Número de produtos por página
  - `current_page` Identificador da página atual

