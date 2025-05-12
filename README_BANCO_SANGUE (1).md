# 🩸 Banco de Sangue - Projeto Full Stack

Este é um sistema completo para gerenciamento e análise de dados de candidatos a doação de sangue. Ele é composto por um **backend em Spring Boot + MySQL** e um **frontend mobile em Flutter**.

---

## 🧱 Estrutura do Projeto

```
Banco Sangue Full/
├── banco_sangue_app/         → Aplicativo Flutter
├── bancosangue/              → API Spring Boot
├── 1.sql                     → Script SQL para criar e popular a base de dados
└── README_BANCO_SANGUE.md    → Este arquivo
```

---

## ⚙️ Tecnologias Utilizadas

- **Backend:** Java 17 + Spring Boot 3.4.5
- **Banco de Dados:** MySQL 8
- **Frontend:** Flutter 3.x

---

## 🗂️ Backend (Spring Boot)

### Pré-requisitos:
- Java 17 ou superior
- MySQL rodando localmente
- Maven

### Configuração:
1. Crie o banco no MySQL:
   ```sql
   CREATE DATABASE banco_sangue;
   ```
2. Execute o script `1.sql` para popular os dados.
3. Configure o `application.properties` (se necessário):
   ```properties
   spring.datasource.url=jdbc:mysql://localhost:3306/banco_sangue
   spring.datasource.username=root
   spring.datasource.password=SUASENHA
   ```
4. Rode o backend:
   ```bash
   cd bancosangue
   mvn spring-boot:run
   ```

### Endpoints disponíveis:
| Rota                      | Método | Descrição                                      |
|---------------------------|--------|------------------------------------------------|
| `/api/upload`             | POST   | Cadastra candidatos (JSON)                     |
| `/api/todos`              | GET    | Lista todos os candidatos                      |
| `/api/por-estado`         | GET    | Quantidade de candidatos por estado            |
| `/api/imc-faixa`          | GET    | Média do IMC por faixa etária                  |
| `/api/obesos`             | GET    | Percentual de obesos por sexo                  |
| `/api/idade-sangue`       | GET    | Idade média por tipo sanguíneo                 |
| `/api/doadores`           | GET    | Doadores compatíveis por receptor              |

---

## 📱 Frontend (Flutter)

### Pré-requisitos:
- Flutter SDK instalado
- Android Studio ou emulador configurado

### Execução:
1. Acesse a pasta:
   ```bash
   cd banco_sangue_app
   ```
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute no emulador:
   ```bash
   flutter run
   ```

> ⚠️ **IMPORTANTE:** o app utiliza `http://10.0.2.2:8082` como endereço local (para emulador Android). Se for rodar no celular real ou em outra rede, altere para o IP da máquina onde está o backend no arquivo:
>
> `lib/services/api_service.dart`
> ```dart
> final String baseUrl = 'http://10.0.2.2:8082/api'; // altere se necessário
> ```

---

## 📝 Observações

- O projeto foi desenvolvido para fins de teste técnico.
- O backend aceita um JSON contendo uma lista de candidatos, que podem ser enviados pela rota `/api/upload`.

---

## 👨‍💻 Autor

Daniel Gomes  
[GitHub](https://github.com/seuusuario) – [LinkedIn](https://linkedin.com/in/seuperfil)