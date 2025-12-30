# Arquitetura do Sistema

```mermaid
flowchart LR
  A[Test Cases JSONL<br/>Prompt Injection defensivo] --> B[Runner Python]

  B --> C1[Target Model 1<br/>DeepSeek Code<br/>OpenAI-compatible API]
  B --> C2[Target Model 2<br/>Dolphin-Mistral<br/>OpenAI-compatible API]
  B --> C3[Target Model 3<br/>GPT-4o-mini<br/>OpenAI API]

  C1 --> D[(Responses Log)]
  C2 --> D
  C3 --> D

  D --> E[Claude Judge<br/>Structured tool output JSON]
  E --> F[(Judgements Log)]

  F --> G[Metrics<br/>ASR, severity,<br/>per-category breakdown]
  G --> H[Reports<br/>CSV + Markdown]
```

## Fluxo de Execução

1. **Test Cases** → Casos de teste de prompt injection em JSONL
2. **Runner Python** → Script principal que orquestra os testes
3. **Target Models** → Modelos sendo testados (DeepSeek, Dolphin-Mistral, GPT-4o-mini)
4. **Responses Log** → Respostas dos modelos armazenadas
5. **Claude Judge** → Claude analisa cada resposta com structured outputs
6. **Judgements Log** → Vereditos do Claude (PASS/WARN/FAIL)
7. **Metrics** → Cálculo de ASR e métricas de segurança
8. **Reports** → Relatórios finais em CSV e Markdown

