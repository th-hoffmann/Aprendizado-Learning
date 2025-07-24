# 🔧 Technical Architecture & Implementation Guide

## 📐 Arquitetura do Sistema

### **Estrutura de Arquivos Planejada**
```
portfolio-manager/
├── portfolio-manager.py           # ✅ Script principal (388 linhas)
├── available-categories.yaml      # ✅ Base de dados das categorias
├── BABY_STEPS.md                 # ✅ Plano de desenvolvimento  
├── TECHNICAL_GUIDE.md            # ✅ Este arquivo
│
├── modules/                       # 📋 PLANEJADO - Módulos do sistema
│   ├── __init__.py
│   ├── config_manager.py          # Gerenciamento de configurações
│   ├── data_manager.py            # CRUD operations
│   ├── ui_components.py           # Componentes de interface
│   ├── report_generator.py        # Geração de relatórios
│   └── backup_manager.py          # Sistema de backup
│
├── data/                          # 📋 PLANEJADO - Dados do usuário
│   ├── courses.yaml               # Lista de cursos
│   ├── certifications.yaml        # Certificações
│   ├── projects.yaml              # Projetos
│   └── metadata.yaml              # Metadados e cache
│
├── templates/                     # 📋 PLANEJADO - Templates
│   ├── readme_template.md         # Template do README
│   ├── project_template.md        # Template de projetos
│   └── badge_templates.yaml       # Templates de badges
│
└── exports/                       # 📋 PLANEJADO - Arquivos gerados
    ├── README.md                  # README gerado
    ├── portfolio_report.html      # Relatório HTML
    └── backup_YYYYMMDD.zip        # Backups
```

---

## 🧩 **Decisões Arquiteturais**

### **1. Linguagem e Dependências**
- **Python 3.12+:** Cross-platform, rica stdlib
- **PyYAML 6.0.2:** Parsing estruturado, melhor que regex
- **pathlib:** Manipulação de paths multiplataforma
- **Sem frameworks pesados:** Manter simplicidade e portabilidade

### **2. Formato de Dados**
- **YAML para configuração:** Legível, estruturado, suporte a Unicode
- **YAML para dados:** Consistência, fácil edição manual
- **JSON como fallback:** Para integrações futuras

### **3. Interface de Usuário**
- **CLI colorido:** Terminal nativo, cores ANSI
- **Menu-driven:** Navegação intuitiva
- **Validação robusta:** Feedback imediato de erros

---

## 🔧 **Implementação dos Próximos Baby Steps**

### **Baby Step 5: Sistema de Menu Principal** 

#### **Estrutura de Funções Planejada:**
```python
def show_main_menu():
    """Menu principal com loop de navegação"""
    
def add_course():
    """Wizard para adicionar curso"""
    
def add_certification():
    """Wizard para adicionar certificação"""
    
def add_project():
    """Wizard para adicionar projeto"""
    
def show_statistics():
    """Dashboard de estatísticas"""
    
def reconfigure_portfolio():
    """Reconfiguração do portfólio"""
    
def backup_restore_menu():
    """Menu de backup e restauração"""
    
def exit_application():
    """Saída segura da aplicação"""
```

#### **Fluxo de Navegação:**
```
Menu Principal
├── 1) Adicionar Curso → Wizard de Curso → Voltar ao Menu
├── 2) Certificação → Wizard de Cert → Voltar ao Menu  
├── 3) Projeto → Wizard de Projeto → Voltar ao Menu
├── 4) Estatísticas → Dashboard → Voltar ao Menu
├── 5) Reconfigurar → Wizard Reconfig → Voltar ao Menu
├── 6) Backup/Restaurar → Submenu → Voltar ao Menu
└── 7) Sair → Confirmação → Exit(0)
```

#### **Implementação Sugerida:**
```python
def show_main_menu():
    """Sistema de menu principal com loop contínuo"""
    menu_options = {
        '1': ('📚 Adicionar Curso', add_course),
        '2': ('🏆 Adicionar Certificação', add_certification),
        '3': ('💻 Adicionar Projeto', add_project),
        '4': ('📊 Ver Estatísticas', show_statistics),
        '5': ('⚙️ Reconfigurar Portfolio', reconfigure_portfolio),
        '6': ('💾 Backup/Restaurar', backup_restore_menu),
        '7': ('👋 Sair', exit_application)
    }
    
    while True:
        print_header("📋 Menu Principal")
        
        for key, (label, _) in menu_options.items():
            print_colored(f"{key}) {label}", Colors.WHITE)
        
        choice = input(f"\n{Colors.YELLOW}Escolha uma opção (1-7): {Colors.END}").strip()
        
        if choice in menu_options:
            _, function = menu_options[choice]
            try:
                function()
            except KeyboardInterrupt:
                print_colored("\n🔄 Voltando ao menu principal...", Colors.YELLOW)
            except Exception as e:
                print_colored(f"\n❌ Erro: {e}", Colors.RED)
                input("Pressione Enter para continuar...")
        else:
            print_colored("❌ Opção inválida. Tente novamente.", Colors.RED)
```

### **Baby Step 6: Sistema de Adição de Conteúdo**

#### **Estrutura de Dados Proposta:**

**courses.yaml:**
```yaml
courses:
  - id: "course_001" 
    name: "Python para Iniciantes"
    platform: "Alura"
    category: "Desenvolvimento de Software"
    subcategory: "Backend (Linguagens, frameworks, APIs, microsserviços)"
    status: "concluido"  # em_andamento, pausado, concluido
    start_date: "2025-01-15"
    end_date: "2025-02-20"
    duration_hours: 40
    url: "https://cursos.alura.com.br/course/python-iniciantes"
    certificate_url: ""
    notes: "Curso fundamental, boa base para seguir"
    created_at: "2025-07-24"
```

**certifications.yaml:**
```yaml
certifications:
  - id: "cert_001"
    name: "AWS Cloud Practitioner"
    institution: "Amazon Web Services"
    category: "Infraestrutura e Cloud Computing"
    issue_date: "2025-03-15"
    expiry_date: "2028-03-15"
    credential_id: "AWS-CP-12345"
    verification_url: "https://aws.amazon.com/verification/..."
    badge_url: "https://images.credly.com/..."
    skills: ["Cloud Computing", "AWS Services", "Cloud Architecture"]
    created_at: "2025-07-24"
```

**projects.yaml:**
```yaml
projects:
  - id: "proj_001"
    name: "Portfolio Manager"
    description: "Sistema de gerenciamento de portfólio educacional"
    category: "Desenvolvimento de Software"
    subcategory: "Backend (Linguagens, frameworks, APIs, microsserviços)"
    technologies: ["Python", "YAML", "CLI", "Cross-platform"]
    repository_url: "https://github.com/user/portfolio-manager"
    demo_url: ""
    status: "em_desenvolvimento"  # planejado, em_desenvolvimento, concluido, pausado
    start_date: "2025-07-24"
    end_date: ""
    highlights: ["Cross-platform compatibility", "YAML-based configuration"]
    created_at: "2025-07-24"
```

#### **Wizards de Input:**
```python
def add_course():
    """Wizard para adicionar novo curso"""
    print_header("📚 Adicionar Novo Curso")
    
    # Carregar configuração do usuário para validar categorias
    user_config = load_user_config()
    available_categories = get_user_categories(user_config)
    
    course_data = {}
    
    # Input básico
    course_data['name'] = input_required("Nome do curso: ")
    course_data['platform'] = input_required("Plataforma (ex: Alura, Udemy): ")
    
    # Seleção de categoria
    course_data['category'] = select_from_list(
        "Categoria:", 
        available_categories, 
        key='name'
    )
    
    # Seleção de subcategoria
    subcategories = get_subcategories(course_data['category'])
    course_data['subcategory'] = select_from_list(
        "Subcategoria:",
        subcategories
    )
    
    # Status e datas
    course_data['status'] = select_from_list(
        "Status:",
        ["em_andamento", "pausado", "concluido"]
    )
    
    course_data['start_date'] = input_date("Data de início (YYYY-MM-DD): ")
    
    if course_data['status'] == 'concluido':
        course_data['end_date'] = input_date("Data de conclusão: ")
        course_data['duration_hours'] = input_number("Duração em horas: ")
    
    # URLs opcionais
    course_data['url'] = input_optional("URL do curso: ")
    course_data['certificate_url'] = input_optional("URL do certificado: ")
    course_data['notes'] = input_optional("Observações: ")
    
    # Confirmar e salvar
    if confirm_data(course_data):
        save_course(course_data)
        print_colored("✅ Curso adicionado com sucesso!", Colors.GREEN)
    else:
        print_colored("❌ Operação cancelada.", Colors.YELLOW)
```

### **Baby Step 7: Sistema de Relatórios**

#### **Métricas Propostas:**
```python
def calculate_statistics():
    """Calcula todas as estatísticas do portfólio"""
    
    stats = {
        'overview': {
            'total_courses': 0,
            'total_certifications': 0, 
            'total_projects': 0,
            'hours_studied': 0,
            'categories_active': 0
        },
        'by_category': {},
        'timeline': {},
        'progress': {
            'courses_completed': 0,
            'courses_in_progress': 0,
            'projects_completed': 0,
            'projects_in_progress': 0
        },
        'recent_activity': []
    }
    
    # Processar dados...
    return stats

def show_statistics():
    """Exibe dashboard de estatísticas colorido"""
    
    stats = calculate_statistics()
    
    print_header("📊 Estatísticas do Portfólio")
    
    # Overview geral
    print_colored("📋 Resumo Geral:", Colors.BOLD + Colors.WHITE)
    print_colored(f"  📚 Cursos: {stats['overview']['total_courses']}", Colors.CYAN)
    print_colored(f"  🏆 Certificações: {stats['overview']['total_certifications']}", Colors.GREEN)
    print_colored(f"  💻 Projetos: {stats['overview']['total_projects']}", Colors.BLUE)
    print_colored(f"  ⏱️ Horas estudadas: {stats['overview']['hours_studied']}", Colors.YELLOW)
    
    # Por categoria
    print_colored("\n📊 Por Categoria:", Colors.BOLD + Colors.WHITE)
    for category, data in stats['by_category'].items():
        print_colored(f"  {data['emoji']} {category}: {data['total']} itens", Colors.WHITE)
    
    # Progresso
    print_colored("\n🎯 Progresso:", Colors.BOLD + Colors.WHITE)
    print_colored(f"  ✅ Cursos concluídos: {stats['progress']['courses_completed']}", Colors.GREEN)
    print_colored(f"  🔄 Cursos em andamento: {stats['progress']['courses_in_progress']}", Colors.YELLOW)
    
    # Atividade recente
    print_colored("\n🕐 Atividade Recente:", Colors.BOLD + Colors.WHITE)
    for activity in stats['recent_activity'][:5]:
        print_colored(f"  {activity['date']} - {activity['description']}", Colors.WHITE)
```

---

## 🏗️ **Padrões de Código Estabelecidos**

### **1. Convenções de Nomenclatura:**
- Funções: `snake_case`
- Constantes: `UPPER_CASE`
- Classes: `PascalCase`
- Arquivos: `lowercase_with_underscores`

### **2. Estrutura de Funções:**
```python
def function_name(parameters):
    """
    Descrição clara da função
    Args: descrição dos parâmetros
    Returns: descrição do retorno
    """
    
    # Validação de entrada
    if not parameters:
        print_colored("❌ Parâmetros inválidos", Colors.RED)
        return None
    
    # Processamento principal
    try:
        result = process_data(parameters)
        print_colored("✅ Operação concluída", Colors.GREEN)
        return result
    except Exception as e:
        print_colored(f"❌ Erro: {e}", Colors.RED)
        return None
```

### **3. Tratamento de Erros:**
- Sempre usar try/except para operações de arquivo
- Mensagens de erro coloridas e específicas
- Fallbacks graceful quando possível
- Log de erros para debug

### **4. Interface de Usuário:**
- Headers padronizados com `print_header()`
- Cores consistentes (verde=sucesso, vermelho=erro, amarelo=aviso)
- Emojis para melhor UX
- Confirmações antes de operações destrutivas

---

## 🧪 **Strategy de Testes**

### **Testes Manuais por Baby Step:**
1. **Funcionalidade básica:** Executar função principal
2. **Casos extremos:** Inputs inválidos, arquivos ausentes  
3. **Integração:** Verificar funcionamento com outros módulos
4. **UX:** Testar fluxo do usuário real

### **Validações Automáticas:**
```python
def validate_config():
    """Valida integridade da configuração"""
    
def validate_data_files():
    """Verifica consistência dos dados"""
    
def check_system_requirements():
    """Verifica dependências do sistema"""
```

---

## 📋 **TODO Technical Debt**

### **Melhorias Futuras:**
- [ ] Sistema de logging adequado
- [ ] Testes unitários automatizados  
- [ ] Cache para operações custosas
- [ ] Internacionalização (i18n)
- [ ] Plugin system para extensibilidade
- [ ] API REST para integrações
- [ ] Docker container para portabilidade

### **Otimizações de Performance:**
- [ ] Lazy loading de dados grandes
- [ ] Indexação para buscas rápidas
- [ ] Compressão de backups
- [ ] Async operations onde aplicável

---

**🎯 Este guia técnico será atualizado conforme a evolução da arquitetura.**
