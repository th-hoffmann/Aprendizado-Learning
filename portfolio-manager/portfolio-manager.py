#!/usr/bin/env python3
"""
Portfolio Manager - Sistema de Gerenciamento de Portfólio de Aprendizado
Versão Python cross-platform que substitui os scripts bash originais.

📚 Documentação:
- BABY_STEPS.md: Plano completo de desenvolvimento em baby steps
- TECHNICAL_GUIDE.md: Arquitetura técnica e guias de implementação

🎯 Status Atual: Baby Step 4 concluído (Wizard de Configuração)
🚀 Próximo: Baby Step 5 (Sistema de Menu Principal)
"""

import os
import sys
import yaml
from pathlib import Path

# Definir caminhos baseados na raiz do projeto
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent  # Vai para /workspaces/Aprendizado-Learning/
CONFIG_FILE = PROJECT_ROOT / "config.yaml"
CATEGORIES_FILE = SCRIPT_DIR / "available-categories.yaml"

# Cores para terminal (cross-platform)
class Colors:
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    PURPLE = '\033[95m'
    CYAN = '\033[96m'
    WHITE = '\033[97m'
    BOLD = '\033[1m'
    END = '\033[0m'

def print_colored(message, color=Colors.WHITE):
    """Imprime mensagem colorida"""
    print(f"{color}{message}{Colors.END}")

def print_header(title):
    """Imprime cabeçalho formatado"""
    print("\n" + "="*50)
    print_colored(f"  {title}", Colors.BOLD + Colors.BLUE)
    print("="*50)

def load_available_categories():
    """
    Carrega as categorias disponíveis do arquivo available-categories.yaml
    Returns: dict com as categorias e suas informações
    """
    if not CATEGORIES_FILE.exists():
        print_colored(f"⚠️  Arquivo {CATEGORIES_FILE} não encontrado!", Colors.YELLOW)
        return {}
    
    try:
        with open(CATEGORIES_FILE, 'r', encoding='utf-8') as file:
            data = yaml.safe_load(file)
            
        # Converter para formato compatível com o código existente
        categories = {}
        
        for i, category in enumerate(data.get('categories', []), 1):
            name = category['name']
            categories[name] = {
                'number': str(i),
                'emoji': category['emoji'],
                'name': name,
                'id': category['id'],
                'color': category['color'],
                'description': category.get('description', ''),
                'subcategories': category.get('subcategories', [])
            }
            
        print_colored(f"✅ Carregadas {len(categories)} categorias do YAML", Colors.GREEN)
        return categories
        
    except yaml.YAMLError as e:
        print_colored(f"❌ Erro ao parsear YAML: {e}", Colors.RED)
        return {}
    except Exception as e:
        print_colored(f"❌ Erro ao ler categorias: {e}", Colors.RED)
        return {}

def check_first_run():
    """
    Verifica se é a primeira execução do sistema
    Returns: True se for primeira execução, False caso contrário
    """
    return not CONFIG_FILE.exists()

def test_category_parser():
    """Função de teste para o parser de categorias"""
    print_colored("🧪 Testando parser de categorias...", Colors.YELLOW)
    categories = load_available_categories()
    
    print_colored(f"📊 Categorias encontradas: {len(categories)}", Colors.CYAN)
    
    for i, (name, data) in enumerate(categories.items(), 1):
        emoji = data.get('emoji', '❓')
        subcat_count = len(data.get('subcategories', []))
        print_colored(f"  {i}. {emoji} {name} ({subcat_count} subcategorias)", Colors.WHITE)
    
    return categories

def run_setup_wizard():
    """
    Executa o wizard de configuração inicial
    Returns: True se configuração foi concluída, False se cancelada
    """
    print_header("🧙‍♂️ Wizard de Configuração")
    
    # Carrega categorias disponíveis
    available_categories = load_available_categories()
    if not available_categories:
        print_colored("❌ Não foi possível carregar as categorias. Abortando configuração.", Colors.RED)
        return False
    
    print_colored("\nEste wizard vai ajudar você a personalizar seu portfólio de aprendizado.", Colors.CYAN)
    print_colored("Escolha entre 3 a 6 áreas de conhecimento para focar.\n", Colors.WHITE)
    
    # Etapa 1: Seleção de categorias (simplificada)
    selected_categories = select_categories_simplified(available_categories)
    if not selected_categories:
        return False
    
    # Etapa 2: Definir prioridades
    prioritized_categories = set_category_priorities(selected_categories)
    if not prioritized_categories:
        return False
    
    # Etapa 3: Configurar subcategorias (opcional)
    final_config = configure_subcategorias(prioritized_categories, available_categories)
    if not final_config:
        return False
    
    # Etapa 4: Gerar config.yaml
    return save_user_config(final_config)

def select_categories_simplified(available_categories):
    """
    Apresenta categorias e permite seleção direta (versão simplificada)
    Returns: lista de categorias selecionadas ou None se cancelado
    """
    print_header("📚 Selecione suas Categorias")
    print_colored("Aqui estão todas as áreas de conhecimento disponíveis:", Colors.CYAN)
    print_colored("💡 Escolha entre 3 a 6 categorias que mais interessam você.\n", Colors.YELLOW)
    
    # Criar lista numerada para seleção
    category_list = list(available_categories.items())
    
    while True:
        # Mostrar categorias com descrições
        for i, (name, data) in enumerate(category_list, 1):
            emoji = data.get('emoji', '❓')
            description = data.get('description', 'Sem descrição')
            subcat_count = len(data.get('subcategories', []))
            
            print_colored(f"{i}. {emoji} {name}", Colors.BOLD + Colors.WHITE)
            print_colored(f"   {description}", Colors.WHITE)
            print_colored(f"   📊 {subcat_count} subcategorias disponíveis\n", Colors.YELLOW)
        
        print_colored("🎯 Digite os números das categorias separados por vírgula", Colors.CYAN)
        print_colored("Exemplo: 1,3,4,6 (entre 3 a 6 categorias)", Colors.YELLOW)
        
        user_input = input(f"\n{Colors.YELLOW}Suas escolhas: {Colors.END}").strip()
        
        if user_input.lower() == 'q':
            print_colored("❌ Configuração cancelada.", Colors.YELLOW)
            return None
        
        # Processar seleção
        try:
            selected_numbers = [int(x.strip()) for x in user_input.split(',')]
            
            # Validar quantidade
            if len(selected_numbers) < 3:
                print_colored("❌ Selecione pelo menos 3 categorias.", Colors.RED)
                continue
            if len(selected_numbers) > 6:
                print_colored("❌ Selecione no máximo 6 categorias.", Colors.RED)
                continue
            
            # Validar números
            if any(num < 1 or num > len(category_list) for num in selected_numbers):
                print_colored("❌ Números inválidos. Use números de 1 a {}.".format(len(category_list)), Colors.RED)
                continue
            
            # Remover duplicatas mantendo ordem
            selected_numbers = list(dict.fromkeys(selected_numbers))
            
            # Buscar categorias selecionadas
            selected_categories = []
            for num in selected_numbers:
                name, data = category_list[num - 1]
                selected_categories.append((name, data))
            
            # Confirmar seleção
            print_colored(f"\n✅ Você selecionou {len(selected_categories)} categorias:", Colors.GREEN)
            for name, data in selected_categories:
                emoji = data.get('emoji', '❓')
                print_colored(f"  • {emoji} {name}", Colors.WHITE)
            
            confirm = input(f"\n{Colors.YELLOW}Confirmar seleção? (s/n): {Colors.END}").lower()
            if confirm in ['s', 'sim', 'y', 'yes']:
                return selected_categories
            else:
                print_colored("\nVamos tentar novamente...\n", Colors.YELLOW)
            
        except ValueError:
            print_colored("❌ Formato inválido. Use números separados por vírgula.", Colors.RED)
            print_colored("Exemplo: 1,3,4,6\n", Colors.YELLOW)

def set_category_priorities(selected_categories):
    """
    Define prioridades para as categorias selecionadas (versão otimizada)
    Returns: lista ordenada por prioridade ou None se cancelado
    """
    print_header("🎯 Definição de Prioridades")
    print_colored("Agora vamos definir a ordem de prioridade das suas categorias escolhidas.", Colors.CYAN)
    print_colored("A primeira categoria será sua MAIOR prioridade.\n", Colors.YELLOW)
    
    while True:
        # Mostrar categorias selecionadas com números
        print_colored("Suas categorias selecionadas:", Colors.BOLD + Colors.WHITE)
        for i, (name, data) in enumerate(selected_categories, 1):
            emoji = data.get('emoji', '❓')
            print_colored(f"  {i}. {emoji} {name}", Colors.WHITE)
        
        print_colored(f"\n💡 Digite os números na ordem de prioridade (do MAIS importante para o menos)", Colors.CYAN)
        print_colored("Exemplo: 3,1,4,2 significa que a categoria 3 é sua prioridade #1", Colors.YELLOW)
        
        user_input = input(f"\n{Colors.YELLOW}Ordem de prioridade: {Colors.END}").strip()
        
        if user_input.lower() == 'q':
            print_colored("❌ Configuração cancelada.", Colors.YELLOW)
            return None
        
        try:
            priority_numbers = [int(x.strip()) for x in user_input.split(',')]
            
            # Validar quantidade exata
            if len(priority_numbers) != len(selected_categories):
                print_colored(f"❌ Digite exatamente {len(selected_categories)} números.", Colors.RED)
                continue
            
            # Validar que todos os números estão presentes
            if set(priority_numbers) != set(range(1, len(selected_categories) + 1)):
                print_colored("❌ Use todos os números de 1 a {} exatamente uma vez.".format(len(selected_categories)), Colors.RED)
                continue
            
            # Reordenar categorias conforme prioridade
            prioritized = []
            for priority_num in priority_numbers:
                name, data = selected_categories[priority_num - 1]
                prioritized.append((name, data))
            
            # Mostrar resultado final
            print_colored(f"\n✅ Ordem de prioridades definida:", Colors.GREEN)
            for i, (name, data) in enumerate(prioritized, 1):
                emoji = data.get('emoji', '❓')
                print_colored(f"  {i}° prioridade: {emoji} {name}", Colors.WHITE)
            
            confirm = input(f"\n{Colors.YELLOW}Confirmar esta ordem? (s/n): {Colors.END}").lower()
            if confirm in ['s', 'sim', 'y', 'yes']:
                return prioritized
            else:
                print_colored("\nVamos redefinir as prioridades...\n", Colors.YELLOW)
                
        except ValueError:
            print_colored("❌ Formato inválido. Use números separados por vírgula.", Colors.RED)
            print_colored("Exemplo: 3,1,4,2\n", Colors.YELLOW)

def configure_subcategorias(prioritized_categories, available_categories):
    """
    Permite configurar subcategorias específicas (opcional)
    Returns: configuração final ou None se cancelado
    """
    print_header("🎛️ Configuração de Subcategorias")
    print_colored("Esta etapa é OPCIONAL. Você pode escolher subcategorias específicas", Colors.CYAN)
    print_colored("ou manter todas disponíveis (recomendado para iniciantes).\n", Colors.YELLOW)
    
    choice = input(f"{Colors.YELLOW}Configurar subcategorias específicas? (s/n): {Colors.END}").lower()
    
    final_config = {
        'portfolio': {
            'created_at': '$(date +%Y-%m-%d)',
            'categories': []
        }
    }
    
    if choice in ['s', 'sim', 'y', 'yes']:
        # TODO: Implementar configuração detalhada de subcategorias
        print_colored("🚧 Configuração detalhada em desenvolvimento...", Colors.YELLOW)
        print_colored("Por enquanto, usando todas as subcategorias disponíveis.", Colors.WHITE)
    
    # Por enquanto, adicionar todas as subcategorias
    for i, (name, data) in enumerate(prioritized_categories, 1):
        category_config = {
            'name': name,
            'id': data.get('id', name.lower().replace(' ', '-')),
            'emoji': data.get('emoji', '❓'),
            'priority': i,
            'enabled': True,
            'subcategories': data.get('subcategories', [])
        }
        final_config['portfolio']['categories'].append(category_config)
    
    return final_config

def save_user_config(config):
    """
    Salva a configuração do usuário no arquivo config.yaml
    Returns: True se salvou com sucesso, False caso contrário
    """
    print_header("💾 Salvando Configuração")
    
    try:
        # Criar diretório se não existir
        CONFIG_FILE.parent.mkdir(parents=True, exist_ok=True)
        
        # Salvar configuração
        with open(CONFIG_FILE, 'w', encoding='utf-8') as file:
            yaml.dump(config, file, default_flow_style=False, 
                     allow_unicode=True, indent=2, sort_keys=False)
        
        print_colored(f"✅ Configuração salva em: {CONFIG_FILE}", Colors.GREEN)
        print_colored(f"📊 {len(config['portfolio']['categories'])} categorias configuradas", Colors.CYAN)
        
        # Mostrar resumo
        print_colored("\n📋 Resumo da sua configuração:", Colors.BOLD + Colors.WHITE)
        for cat in config['portfolio']['categories']:
            emoji = cat.get('emoji', '❓')
            priority = cat.get('priority', '?')
            subcat_count = len(cat.get('subcategories', []))
            print_colored(f"  {priority}° {emoji} {cat['name']} ({subcat_count} subcategorias)", Colors.WHITE)
        
        return True
        
    except Exception as e:
        print_colored(f"❌ Erro ao salvar configuração: {e}", Colors.RED)
        return False

def main():
    """Função principal do sistema"""
    print_header("🎓 Portfolio Manager")
    print_colored("Sistema de Gerenciamento de Portfólio de Aprendizado", Colors.CYAN)
    
    # TESTE TEMPORÁRIO: Testar parser de categorias
    if len(sys.argv) > 1 and sys.argv[1] == "--test":
        test_category_parser()
        return
    
    # Verifica se é primeira execução
    if check_first_run():
        print_colored("\n👋 Bem-vindo! Parece que é sua primeira vez aqui.", Colors.GREEN)
        print_colored("Vamos configurar seu portfólio personalizado...", Colors.YELLOW)
        
        # Executar wizard de configuração inicial
        if run_setup_wizard():
            print_colored("\n🎉 Configuração concluída com sucesso!", Colors.GREEN)
            print_colored("Agora você pode usar o sistema normalmente.", Colors.CYAN)
        else:
            print_colored("\n❌ Configuração cancelada.", Colors.YELLOW)
        return
    
    # Se já configurado, mostra menu principal
    print_colored("\n📋 Portfolio já configurado!", Colors.GREEN)
    show_main_menu()

def show_main_menu():
    """Mostra o menu principal para usuários já configurados"""
    print_header("📋 Menu Principal")
    print("1) Adicionar Curso")
    print("2) Adicionar Certificação") 
    print("3) Adicionar Projeto")
    print("4) Ver Estatísticas")
    print("5) Reconfigurar Portfolio")
    print("6) Backup/Restaurar")
    print("7) Sair")
    
    choice = input(f"\n{Colors.YELLOW}Escolha uma opção (1-7): {Colors.END}")
    
    # TODO: Implementar as opções do menu
    print_colored(f"\n🚧 Opção {choice} em construção...", Colors.YELLOW)

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print_colored("\n\n👋 Até logo!", Colors.GREEN)
        sys.exit(0)
    except Exception as e:
        print_colored(f"\n❌ Erro: {e}", Colors.RED)
        sys.exit(1)
