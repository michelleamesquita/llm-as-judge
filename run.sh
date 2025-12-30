#!/bin/bash
# Script para rodar o LLM Injection Harness com as configurações corretas

cd "$(dirname "$0")"

# Carregar variáveis de ambiente do arquivo .env
if [ -f .env ]; then
    echo "📝 Carregando configurações do .env..."
    export $(grep -v '^#' .env | grep -v '^$' | xargs)
else
    echo "⚠️  Arquivo .env não encontrado!"
    echo "   Crie um arquivo .env com as chaves API necessárias."
    echo "   Exemplo:"
    echo "   ANTHROPIC_API_KEY=sua-chave"
    echo "   OPENAI_API_KEY=sua-chave"
    exit 1
fi

# Verificar se as chaves necessárias estão definidas
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "❌ ANTHROPIC_API_KEY não está definida no .env"
    exit 1
fi

if [ -z "$OPENAI_API_KEY" ]; then
    echo "⚠️  OPENAI_API_KEY não está definida no .env"
    echo "   O GPT-4o-mini não será testado."
fi

echo "🚀 Iniciando testes de robustez contra prompt injection..."
echo "📊 Testando 3 modelos (DeepSeek + Dolphin-Mistral + GPT-4o-mini) com 7 casos de teste..."
echo ""

./venv/bin/python llm_injection_harness.py

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Testes concluídos com sucesso!"
    echo "📁 Resultados salvos em: out/"
    echo ""
    ls -lh out/
else
    echo ""
    echo "❌ Erro durante a execução"
fi

