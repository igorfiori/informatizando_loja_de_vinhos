# 🍷 Informatizando Loja de Vinhos

Este projeto consiste na criação e gestão de um **banco de dados relacional** para uma loja de vinhos, incluindo informações sobre **vinícolas, vinhos e regiões vinícolas**.

## 📌 Funcionalidades

- 📂 **Criação do banco de dados `vinicula_bd`**
- 🏭 **Gerenciamento de Vinícolas**
- 🍷 **Cadastro e consulta de vinhos**
- 🌍 **Registro de regiões vinícolas**
- 👤 **Criação do usuário `Sommelier` com permissões específicas**
- 🔍 **Consultas SQL para análise de vinhos e vinícolas**

## 🛠️ Estrutura do Banco de Dados

### 🔹 Tabelas Criadas

1. **`Regiao`**: Contém informações sobre as regiões vinícolas.
2. **`Vinicola`**: Armazena os dados das vinícolas, incluindo nome, telefone e e-mail.
3. **`Vinho`**: Registra os vinhos, especificando nome, tipo, ano e descrição.

### 🔹 Relacionamentos

- Cada **vinícola** pertence a uma **região**.
- Cada **vinho** está associado a uma **vinícola**.

## 🗄️ Dados Inseridos

### 🌍 Regiões Cadastradas
- Vale dos Vinhedos
- Campanha Gaúcha
- Serra Gaúcha
- Pampa Gaúcho
- Litoral Norte

### 🏭 Vinícolas Registradas
- Vinícola Aurora
- Miolo Wine Group
- Salton Vinhos
- Pizzato Vinhas e Vinhos
- Casa Valduga

### 🍷 Vinhos Cadastrados
- Aurora Reserva Merlot (Tinto, 2015)
- Lote 43 (Tinto, 2016)
- Espumante Salton Intenso Brut (Espumante, 2018)
- Pizzato Fausto Merlot (Tinto, 2017)
- Casa Valduga Raízes Cabernet Franc (Tinto, 2019)

## 🔐 Gerenciamento de Permissões

- Criado o usuário **`Sommelier`** com senha `010203`
- **Permissões concedidas:**
  - **SELECT** na tabela `Vinho`
  - **SELECT** em colunas específicas (`codVinicola` e `nomeVinicola`) da tabela `Vinicola`
  - **Limite de 40 consultas por hora** para o usuário `Sommelier`

## 🔎 Consulta SQL para Relatório

Para listar os **vinhos**, suas respectivas **vinícolas** e **regiões**:

## 📌 Desenvolvido para fins acadêmicos e de aprendizado sobre modelagem e gestão de banco de dados.
Se tiver alguma dúvida, fique à vontade para contribuir! 🍷✨

```sql

SELECT 
    v.nomeVinho,
    v.anoVinho,
    vi.nomeVinicola,
    r.nomeRegiao
FROM 
    Vinho v
INNER JOIN 
    Vinicola vi ON v.Vinicola_idVinicola = vi.idVinicola
INNER JOIN 
    Regiao r ON vi.Regiao_idRegiao = r.idRegiao;´´´

