## Apache Airflow v 2.6.0-python3.10
Contém um ambiente de desenvolvimento local do Apache Airflow e os workflows (DAGs).

### Requisitos mínimos

- Docker
- Docker Compose v1.29.1 ou mais recente

### Rodando o Airflow com o Make do linux:
O Comando abaixo vai fazer o build da imagem docker; subir os serviços e popular o banco
```
make up
```

Para acessar o container que está o Airflow rode o seguinte comando:
```
make bash
```

Para finalizar os serviços do airflow rode o seguinte comando:
```
make down
```

### Interface Web

Uma vez que o cluster estiver rodando
- acesse a interface web em http://localhost:8080

Credenciais de acesso:
> usuário: airflow, senha: airflow. 

### Cleaning up

Caso queira parar e apagar os containeres, imagens e volumes (banco de dados) que foram criados:
```
docker-compose down --volumes --rmi all
```
