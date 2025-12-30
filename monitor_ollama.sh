#!/bin/bash
# Script para monitorar atividade do Ollama em tempo real

echo "🔍 Monitorando Ollama (Ctrl+C para sair)..."
echo ""
echo "Modelos carregados e suas métricas:"
echo "----------------------------------------"

while true; do
    clear
    echo "🔍 Status do Ollama - $(date '+%H:%M:%S')"
    echo "========================================"
    echo ""
    
    # Mostra processos do Ollama
    echo "📊 Processos:"
    ps aux | grep "[o]llama" | grep -v grep | awk '{printf "   PID: %s | CPU: %s%% | MEM: %s%%\n", $2, $3, $4}' || echo "   Nenhum processo ativo"
    
    echo ""
    echo "🤖 Modelos em uso:"
    
    # Lista modelos rodando (através de chamadas à API)
    response=$(curl -s http://localhost:11434/api/ps 2>/dev/null)
    if [ $? -eq 0 ] && [ ! -z "$response" ]; then
        echo "$response" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    if 'models' in data and len(data['models']) > 0:
        for model in data['models']:
            name = model.get('name', 'unknown')
            size = model.get('size', 0)
            size_mb = size / (1024*1024)
            print(f'   ✓ {name} ({size_mb:.1f} MB)')
    else:
        print('   Nenhum modelo em execução no momento')
except:
    print('   Aguardando requisições...')
" 2>/dev/null || echo "   Aguardando requisições..."
    else
        echo "   ⚠️  Ollama não está respondendo"
    fi
    
    echo ""
    echo "📈 Últimas requisições:"
    # Tenta pegar logs recentes se disponível
    tail -n 3 ~/.ollama/logs/server.log 2>/dev/null | sed 's/^/   /' || echo "   (logs não disponíveis)"
    
    echo ""
    echo "----------------------------------------"
    echo "Pressione Ctrl+C para sair"
    
    sleep 2
done

