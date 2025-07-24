# 🎓 Portfolio Manager

## 📖 Sobre o Projeto

Sistema de gerenciamento de portfólio educacional desenvolvido em Python, seguindo a metodologia **Baby Steps** para aprendizado prático de programação. Substitui scripts bash complexos por uma solução cross-platform robusta e amigável.

## 🎯 Objetivo

Transformar um portfólio pessoal de aprendizado em um **template universal para GitHub**, permitindo que qualquer pessoa crie e gerencie seu próprio sistema de acompanhamento educacional.

## ✅ Status Atual

### **Baby Steps Concluídos:**
- ✅ **Step 1:** Análise e planejamento da migração bash → Python
- ✅ **Step 2:** Setup inicial com estrutura Python cross-platform  
- ✅ **Step 3:** Migração de dados Markdown → YAML estruturado
- ✅ **Step 4:** Wizard interativo de configuração completo

### **Próximo Baby Step:**
🚧 **Step 5:** Sistema de menu principal com 7 funcionalidades

## 🚀 Como Usar

### **Primeira Execução:**
```bash
cd portfolio-manager
python3 portfolio-manager.py
```

O sistema detectará que é sua primeira vez e iniciará o **wizard de configuração**:
1. Apresentará 6 categorias de conhecimento disponíveis
2. Permitirá escolher 3-6 categorias de seu interesse  
3. Definirá ordem de prioridades
4. Gerará arquivo `config.yaml` personalizado

### **Uso Regular:**
Após configuração, o sistema apresenta menu com opções:
1. 📚 Adicionar Curso
2. 🏆 Adicionar Certificação  
3. 💻 Adicionar Projeto
4. 📊 Ver Estatísticas
5. ⚙️ Reconfigurar Portfolio
6. 💾 Backup/Restaurar
7. 👋 Sair

## 🏗️ Arquitetura

### **Arquivos Principais:**
```
portfolio-manager/
├── portfolio-manager.py         # Script principal (400+ linhas)
├── available-categories.yaml    # Base de categorias (6 áreas)
├── config.yaml                  # Configuração do usuário (gerado)
├── BABY_STEPS.md               # Plano completo de desenvolvimento
└── TECHNICAL_GUIDE.md          # Guia técnico e arquitetura
```

### **Categorias Disponíveis:**
1. 💻 **Desenvolvimento de Software** (6 subcategorias)
2. 🤖 **Dados e Inteligência Artificial** (5 subcategorias)  
3. ☁️ **Infraestrutura e Cloud Computing** (5 subcategorias)
4. 🔒 **Segurança da Informação** (6 subcategorias)
5. 📊 **Gestão, Metodologias e Produto** (5 subcategorias)
6. 🧠 **Fundamentos e Habilidades Essenciais** (7 subcategorias)

## 🧪 Teste Rápido

### **Testar Parser de Categorias:**
```bash
python3 portfolio-manager.py --test
```

### **Executar Wizard Completo:**
```bash
# Remove configuração anterior (se existir)
rm -f ../config.yaml

# Executa wizard
python3 portfolio-manager.py
```

## 🔧 Tecnologias

- **Python 3.12+:** Linguagem principal
- **PyYAML 6.0.2:** Parsing de dados estruturados
- **pathlib:** Manipulação de paths cross-platform
- **Terminal Colors:** Interface colorida nativa

## 📚 Metodologia Educacional

Este projeto segue a **metodologia Baby Steps**:
- **Incremental:** Cada step adiciona funcionalidade completa
- **Validado:** Todo código é testado antes do próximo passo  
- **Documentado:** Progresso registrado em tempo real
- **Cross-platform:** Compatibilidade desde o início

## 🎯 Roadmap

### **Fase Atual - Funcionalidades Core:**
- 🚧 Baby Step 5: Sistema de Menu Principal
- 📋 Baby Step 6: Adição de Conteúdo (Cursos/Certificações/Projetos)  
- 📋 Baby Step 7: Relatórios e Estatísticas

### **Próximas Fases:**
- **Persistência:** Sistema de dados, backup, reconfiguração
- **Geração:** README.md dinâmico, badges, dashboard HTML
- **Template:** Distribuição como template GitHub universal

## 📖 Documentação Completa

- **[BABY_STEPS.md](BABY_STEPS.md):** Plano completo com 16 baby steps planejados
- **[TECHNICAL_GUIDE.md](TECHNICAL_GUIDE.md):** Arquitetura técnica e padrões de código

## 🎓 Contexto Educacional

Este projeto serve como exemplo prático de:
- Migração de tecnologias (bash → Python)
- Desenvolvimento iterativo com baby steps
- Design de CLI amigável e cross-platform  
- Estruturação de dados com YAML
- Padrões de código limpo e documentado

---

**📝 Última atualização:** 24/07/2025 - Baby Step 4 concluído  
**👨‍🏫 Professor:** GitHub Copilot - Metodologia Baby Steps  
**🎯 Objetivo:** Template universal de portfólio educacional
