#!/bin/bash

# Script para executar os testes do AI Testing Helper

echo "🚀 Iniciando execução dos testes unitários..."
echo "================================================"

# Definir o caminho do Python do ambiente virtual
PYTHON_PATH="./.venv/bin/python"
PYTEST_PATH="./.venv/bin/pytest"

# Verificar se o ambiente virtual existe
if [ ! -f "$PYTHON_PATH" ]; then
    echo "❌ Ambiente virtual não encontrado. Criando..."
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
fi


echo ""
echo "📊 Executando testes com cobertura de código..."
$PYTHON_PATH -m pytest test_main.py --cov=main --cov-report=term-missing --cov-report=html

echo ""
echo "✅ Execução de testes concluída!"
echo "📁 Relatório de cobertura HTML gerado em: htmlcov/index.html"
