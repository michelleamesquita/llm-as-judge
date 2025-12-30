flowchart LR
  A[Test Cases (JSONL)\nPrompt Injection (defensivo)] --> B[Runner Python]

  B --> C1[Target Model #1\nDeepSeek Code\nOpenAI-compatible API]
  B --> C2[Target Model #2\n\"Mixtral\"\nOpenAI-compatible API]

  C1 --> D[(Responses Log)]
  C2 --> D

  D --> E[Claude Judge\n(Structured tool output JSON)]
  E --> F[(Judgements Log)]

  F --> G[Metrics\nASR, severity,\nper-category breakdown]
  G --> H[Reports\nCSV + Markdown]
