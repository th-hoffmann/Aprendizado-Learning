# 🗂️ Navegação Rápida - Documentação do Projeto

## 📚 Documentos Principais

| Arquivo | Propósito | Quando Ler |
|---------|-----------|------------|
| **[PROJECT_CONTEXT.md](PROJECT_CONTEXT.md)** | 🧠 **Contexto completo** - Todas as decisões tomadas | **PRIMEIRO** - Para entender o projeto |
| **[MIGRATION_PLAN.md](MIGRATION_PLAN.md)** | 📋 **Roadmap técnico** - Como implementar | **SEGUNDO** - Para plano de execução |
| **[NEXT_STEPS.md](NEXT_STEPS.md)** | 🚀 **Próximos passos** - O que fazer agora | **TERCEIRO** - Para começar desenvolvimento |
| **[DECISIONS.md](DECISIONS.md)** | 🤔 **Raciocínio** - Por que cada decisão foi tomada | **Referência** - Quando questionar escolhas |
| **[INVENTORY.md](INVENTORY.md)** | 📋 **Inventário** - O que existe atualmente | **Referência** - Durante migração |

## 🎯 Guia de Uso

### **🆕 Nova Sessão/Pessoa**
1. Ler **PROJECT_CONTEXT.md** (5 min) - Entender tudo
2. Ler **MIGRATION_PLAN.md** (10 min) - Ver roadmap  
3. Ler **NEXT_STEPS.md** (3 min) - Saber o que fazer
4. Começar desenvolvimento! 🚀

### **📊 Durante Desenvolvimento**
- **DECISIONS.md** - "Por que escolhemos X?"
- **INVENTORY.md** - "Como funciona o sistema atual?"
- **MIGRATION_PLAN.md** - "Qual é o próximo milestone?"

### **❓ FAQ Rápido**
- **Por que Python?** → [DECISIONS.md - Seção Python](DECISIONS.md#-por-que-python-vs-javascriptbash)
- **Por que Template GitHub?** → [DECISIONS.md - Seção GitHub](DECISIONS.md#-por-que-github-template-vs-pypinpm)
- **O que migrar primeiro?** → [NEXT_STEPS.md - Semana 1](NEXT_STEPS.md#semana-1---fase-atual)
- **Que funcionalidades preservar?** → [INVENTORY.md - Pontos Fortes](INVENTORY.md#-pontos-fortes-a-preservar)

## 📁 Estrutura de Arquivos

### **📝 Documentação (Meta)**
```
├── README.md                 # 📖 Guia de navegação (este arquivo)
├── PROJECT_CONTEXT.md        # 🧠 Contexto e decisões principais  
├── MIGRATION_PLAN.md         # 📋 Plano técnico detalhado
├── NEXT_STEPS.md            # 🚀 Próximos passos específicos
├── DECISIONS.md             # 🤔 Raciocínio das decisões
└── INVENTORY.md             # 📋 Inventário do sistema atual
```

### **💻 Sistema Atual**
```
├── README.md + README_pt-br.md    # Portfolio atual
├── Learning-Journey/              # Conteúdo do portfolio  
└── Resources/                     # Scripts bash + templates
```

## 🎯 Estado do Projeto

### **✅ Concluído**
- [x] Análise completa do sistema atual
- [x] Decisões estratégicas tomadas
- [x] Stack tecnológico definido  
- [x] Roadmap de 6 semanas criado
- [x] Documentação completa escrita

### **🔄 Em Andamento**
- [ ] **Semana 1**: Implementação básica Python

### **📋 Próximo**
- [ ] Criar `portfolio.py` básico
- [ ] Implementar comando `add course`
- [ ] Sistema de templates Jinja2
- [ ] Configuração YAML

## 💡 Dicas de Desenvolvimento

### **🧪 Como Testar**
```bash
# Testar scripts atuais
./Resources/Scripts/portfolio-manager.sh

# Ver badges em ação
./Resources/Scripts/enhanced-badge-generator.sh

# Validar estrutura  
./Resources/Scripts/validate-portfolio.sh
```

### **📖 Entender o Sistema**
1. Explorar `Learning-Journey/` - ver estrutura de conteúdo
2. Ler `Resources/Templates/` - entender templates
3. Executar scripts bash - ver funcionalidades em ação

### **🎯 Foco na Migração**
- **Preservar** toda funcionalidade existente
- **Melhorar** compatibilidade cross-platform  
- **Simplicar** configuração para novos usuários
- **Manter** qualidade visual dos badges

---

**🚀 Para começar**: Leia PROJECT_CONTEXT.md e depois NEXT_STEPS.md  
**📧 Para dúvidas**: Consulte DECISIONS.md  
**🔍 Para referência**: Use INVENTORY.md  

**Status**: ✅ Documentação completa - Pronto para desenvolvimento!
