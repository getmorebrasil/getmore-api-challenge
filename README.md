# getmore-api challenge

 **Considere o seguinte cenário. Sua empresa acabou de fechar uma novo produto e o PO detalhou as seguintes necessidades:**
 
  Ter uma api que gerencía um catálogo de produtos, ela deve cadastrar os produtos no banco, listar os produtos, listar as stores, listar produtos por loja e o acesso ao serviço deve ser controlado por autenticação.
  
 **Com as necessidades requeridas pelo PO foi decidido entre o time os seguintes requisitos:**
 - Cadastrar produtos - deve ser capturado os produtos da seguinte url http://compramais.stg.product.svc.getmore.com.br/v1/products.
 - Cadastrar lojas - deve ser capturado todas as lojas da seguinte url http://compramais.stg.product.svc.getmore.com.br/v1/stores.
 - Listar produtos - deve existir uma rota /products que retorna todos os produtos.
 - Listar lojas - deve existir uma rota /stores que retorna todas as lojas.
 - Listar produtos por loja - deve existir uma rota /stores/:urlName/products que retorna todos os produtos da loja corrente.
 - Autenticador - deve existir um meio de autenticação para poder acessar o serviço.

  **A estrutura mínima de arquivos deve estar da seguinte forma:**
  ```
    src
    ---services
    -----stores(file)
    -----products(file)
    ---routes
    -----products(file)
    -----stores(file)    
    ---setup    
    -----index(file)    
    ---index(file)    
    migrations    
    ---new-up.sql(file)    
  ```
 - No diretório services deve existir as funções de crud da api.
 - No diretório setup deve existir as funções de conexão com o banco de dados e adição das rotas ao app.
 - No arquivo index deve existir o start do app.
 - No diretório migrations deve existir o esquema do banco de dados.
 - Os dados das lojas que devem ser armazenados no banco são os seguintes: name, imageUrl e shortDescription.
 - Os dados dos produtos que devem ser armazenados no banco são os seguintes: title, value, price, urlTitle e storeName.

**Tecnologias:**
 - Sua api deve ser construida em javascript ou typescript. Caso escolha typescript sua api transpilada deve ser gerada no diretório ./dist;
 - Como base de dados você pode utlilizar sqlite ou postgres. Caso escolha postgres você deve dockerizar sua api;
 - Para gerar o autenticador você deve utilizar um middleware de sua preferencia;
 - Você deve utilizar variáveis de ambiente e também criar um arquivo .env.example contendo suas variáveis de ambiante que serão utilizadas;

**Documentação:**
 - Nesse mesmo readme, na sessão "Informaçãoes de uso da api", você deve adicionar as informações de uso da api, variáveis de ambiente e também de autenticação para acesso as rotas do serviço;

**Avaliação:**
 - Será avaliado organização do código, qualidade do código, desempenho da api, semânticas dos nomes das variáveis e funções.

**Dicas:**
 - Tente utilizar especificações ES6<;
 - Perfira sempre soluções do paradigma funcional;
 - utilize async await ao seu favor.

**Aqui vão as etapas:**
 - Faça um fork desse repositório;
 - Crie uma Pull Request com sua fork
 
 **Informaçãoes de uso da api**
