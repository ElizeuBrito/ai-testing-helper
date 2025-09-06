# IA Testing Helper

## Introdução

O IA Testing Helper é uma ferramenta de Inteligência Artificial generativa projetada para auxiliar desenvolvedores e profissionais de Quality Assurance (QA) na criação de testes unitários. Por meio de uma interface de chat intuitiva, os usuários poderão submeter funções de código e receber sugestões de testes unitários robustos e abrangentes, otimizando o ciclo de desenvolvimento e garantindo a qualidade do software.

## A problemática

A criação de testes unitários é uma prática fundamental no desenvolvimento de software, essencial para garantir a qualidade, a manutenibilidade e a estabilidade do código. No entanto, este processo enfrenta desafios significativos que impactam a produtividade e a eficácia das equipes de desenvolvimento:

- **Consumo de Tempo e Recursos**: A escrita manual de testes unitários é uma tarefa trabalhosa e demorada, que consome um tempo precioso dos desenvolvedores, desviando o foco do desenvolvimento de novas funcionalidades.

- **Complexidade e Manutenção**: Funções com lógicas complexas exigem a criação de múltiplos cenários de teste, incluindo casos de borda (edge cases) que muitas vezes são negligenciados. Além disso, a manutenção desses testes ao longo da evolução do código representa um esforço contínuo.

- **Curva de Aprendizagem**: Desenvolvedores, especialmente os mais novos na equipe ou em um projeto, podem ter dificuldades em compreender todas as nuances de uma função para criar testes que cubram todos os cenários relevantes.

- **Inconsistência na Qualidade dos Testes**: A qualidade e a abrangência dos testes podem variar significativamente entre diferentes desenvolvedores e equipes, resultando em uma cobertura de testes desigual e potenciais falhas não detectadas.

- **Dificuldade em Isolar Unidades**: Em código com alto acoplamento, isolar uma unidade para teste se torna uma tarefa complexa, desencorajando a prática da escrita de testes.

O **IA Testing Helper** visa endereçar esses problemas, automatizando e simplificando a geração de testes unitários, permitindo que as equipes de desenvolvimento aumentem a cobertura de testes e a qualidade do código de forma mais eficiente.

## Quem utilizará?

A ferramenta foi projetada para ser utilizada por dois perfis principais dentro do ciclo de desenvolvimento de software:

- **Desenvolvedores (Back-end, Front-end, Full-stack)**: São os principais responsáveis pela escrita do código e, tradicionalmente, pela criação dos testes unitários. Para eles, o IA Testing Helper servirá como um assistente inteligente, acelerando a criação de testes, sugerindo casos de teste que talvez não tivessem considerado e garantindo uma base sólida de testes para o código que produzem. Isso permite que se concentrem mais na lógica de negócio e na implementação de novas funcionalidades.

- **Analistas de Qualidade (QAs) e Engenheiros de Teste**: Embora o foco principal dos QAs seja em testes de integração, sistema e end-to-end, a participação na estratégia de testes unitários é cada vez mais comum. Com o IA Testing Helper, os profissionais de QA poderão revisar os testes gerados, sugerir melhorias e até mesmo gerar testes para funções críticas de forma autônoma, contribuindo para uma cultura de qualidade desde as fases iniciais do desenvolvimento. A ferramenta pode servir como um ponto de colaboração entre desenvolvedores e QAs para garantir a robustez do software.

## Funcionalidade Principal

O núcleo do IA Testing Helper reside em sua capacidade de gerar testes unitários de forma inteligente e interativa. A funcionalidade principal será entregue por meio de uma interface de chat simples e direta, implementada com Streamlit:

### Geração de Testes Unitários via Chat:

- **Entrada do Usuário**: O usuário (desenvolvedor ou QA) irá interagir com um chat onde poderá colar o trecho de código de uma função específica escrita em Python.

- **Processamento com IA Generativa**: A ferramenta enviará o código para um modelo de linguagem de grande porte (LLM) especializado em compreensão e geração de código. A IA analisará a lógica da função, identificando os diferentes caminhos de execução, parâmetros de entrada e possíveis saídas.

- **Geração dos Testes**: Com base nessa análise, a IA irá gerar o código completo dos testes unitários para a função fornecida. Os testes gerados incluirão:

  - **Testes para o "caminho feliz" (happy path)**: Cenários onde a função se comporta como o esperado com entradas válidas.

  - **Testes para casos de borda (edge cases)**: Cenários com entradas inesperadas, como valores nulos, vazios, tipos de dados incorretos ou valores limites.

  - **Assertivas Relevantes**: Utilização de asserts adequados para verificar o comportamento esperado da função em cada cenário.

  - **Apresentação dos Resultados**: O código dos testes unitários gerados será apresentado de forma clara na interface de chat, pronto para ser copiado e integrado ao projeto. 

Essa funcionalidade central permitirá uma criação de testes mais rápida, consistente e abrangente, melhorando significativamente a produtividade e a qualidade do software desenvolvido.


## Como rodar localmente

1. Instale o Python 3.10 ou superior.
2. Crie e ative um ambiente virtual:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```
3. Instale as dependências:
   ```bash
   pip install -r requirements.txt
   ```
4. Execute a API:
   ```bash
   streamlit run main.py
   ```
5. Acesse `http://localhost:8501` para acessar o chat.

Obs.: Para desabilitar o ambiente virtual rode o comando `deactivate` no terminal

### Testes Unitários

#### Execução Simples
```bash
pytest test_main.py -v
```

#### Execução com Cobertura
```bash
pytest test_main.py --cov=main --cov-report=term-missing --cov-report=html
```

#### Execução por Categoria
```bash
# Apenas testes unitários
pytest test_main.py -m "not integration" -v

# Apenas testes de integração
pytest test_main.py -m integration -v
```

#### Script Automatizado
```bash
./run_tests.sh
```