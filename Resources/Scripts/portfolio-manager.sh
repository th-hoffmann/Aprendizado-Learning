#!/bin/bash

# Learning Portfolio Manager
# Script para gerenciar registros no portfólio de aprendizado

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TEMPLATES_DIR="$REPO_ROOT/Resources/Templates"
JOURNEY_DIR="$REPO_ROOT/Learning-Journey"

# Importar gerador de badges avançado
source "$SCRIPT_DIR/enhanced-badge-generator.sh"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir mensagens coloridas
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Função para mostrar o menu principal
show_main_menu() {
    clear
    print_message "$BLUE" "======================================"
    print_message "$BLUE" "    Learning Portfolio Manager"
    print_message "$BLUE" "======================================"
    echo
    echo "1) Adicionar Nova Certificação"
    echo "2) Adicionar Novo Curso"
    echo "3) Adicionar Novo Projeto"
    echo "4) Adicionar Novo Bootcamp"
    echo "5) Adicionar Novo Workshop"
    echo "6) Listar Registros por Área"
    echo "7) Gerar Relatório de Progresso"
    echo "8) Sair"
    echo
    read -rp "Escolha uma opção (1-8): " choice
}

# Função para escolher área de conhecimento
choose_area() {
    echo
    print_message "$YELLOW" "Áreas disponíveis:"
    echo "1) DevOps"
    echo "2) Cloud Computing"
    echo "3) Security"
    echo "4) Linux Infrastructure"
    echo "5) Programming"
    echo "6) Data Science"
    echo
    read -rp "Escolha a área (1-6): " area_choice
    
    case $area_choice in
        1) echo "01_DevOps" ;;
        2) echo "02_Cloud-Computing" ;;
        3) echo "03_Security" ;;
        4) echo "04_Linux-Infrastructure" ;;
        5) echo "05_Programming" ;;
        6) echo "06_Data-Science" ;;
        *) print_message "$RED" "Opção inválida"; return 1 ;;
    esac
}

# Função para adicionar certificação
add_certification() {
    print_message "$GREEN" "=== Adicionar Nova Certificação ==="
    
    local area
    area=$(choose_area) || return 1
    
    echo
    read -rp "Nome da certificação: " cert_name
    read -rp "Certificadora: " cert_provider
    read -rp "Data de obtenção (DD/MM/AAAA): " cert_date
    read -rp "ID da credencial: " cert_id
    
    # Criar nome do arquivo
    local file_name
    file_name=$(echo "$cert_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
    local cert_dir="$JOURNEY_DIR/$area/Certifications"
    local cert_file="$cert_dir/${cert_date//\//-}_${cert_provider}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$cert_dir"
    
    # Copiar template e personalizar
    cp "$TEMPLATES_DIR/certification-template.md" "$cert_file"
    
    # Substituir placeholders
    sed -i "s|\[Nome da Certificação\]|$cert_name|g" "$cert_file"
    sed -i "s|\[Nome da Certificadora\]|$cert_provider|g" "$cert_file"
    sed -i "s|\[DD/MM/AAAA\]|$cert_date|g" "$cert_file"
    sed -i "s|\[ID único da credencial\]|$cert_id|g" "$cert_file"
    
    # Aplicar badges personalizados
    enhance_certification_template "$cert_file" "$cert_provider" "$cert_name" "$area" "$cert_date"
    
    print_message "$GREEN" "Certificação adicionada com badges personalizados: $cert_file"
    read -rp "Pressione Enter para continuar..."
}

# Função para adicionar curso
add_course() {
    print_message "$GREEN" "=== Adicionar Novo Curso ==="
    
    local area
    area=$(choose_area) || return 1
    
    echo
    read -rp "Nome do curso: " course_name
    read -rp "Instituição: " course_provider
    read -rp "Data de início (DD/MM/AAAA): " start_date
    read -rp "Carga horária: " course_hours
    
    # Criar nome do arquivo
    local file_name
    file_name=$(echo "$course_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
    local course_dir="$JOURNEY_DIR/$area/Courses"
    local course_file="$course_dir/${start_date//\//-}_${course_provider}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$course_dir"
    
    # Copiar template e personalizar
    cp "$TEMPLATES_DIR/course-template.md" "$course_file"
    
    # Substituir placeholders
    sed -i "s|\[Nome do Curso\]|$course_name|g" "$course_file"
    sed -i "s|\[Nome da Instituição\]|$course_provider|g" "$course_file"
    sed -i "s|\[DD/MM/AAAA\]|$start_date|g" "$course_file"
    sed -i "s|\[XX horas\]|$course_hours horas|g" "$course_file"
    
    # Aplicar badges personalizados baseados na plataforma e conteúdo
    enhance_course_template "$course_file" "$course_provider" "$course_name" "$area"
    
    print_message "$GREEN" "Curso adicionado com badges inteligentes: $course_file"
    read -rp "Pressione Enter para continuar..."
}

# Função para adicionar projeto
add_project() {
    print_message "$GREEN" "=== Adicionar Novo Projeto ==="
    
    local area
    area=$(choose_area) || return 1
    
    echo
    read -rp "Nome do projeto: " project_name
    read -rp "Status (Em andamento/Concluído/Planejado): " project_status
    read -rp "Data de início (DD/MM/AAAA): " start_date
    read -rp "Nível (Iniciante/Intermediário/Avançado): " project_level
    
    # Criar nome do arquivo
    local file_name
    file_name=$(echo "$project_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
    local project_dir="$JOURNEY_DIR/$area/Projects"
    local project_file="$project_dir/${start_date//\//-}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$project_dir"
    
    # Copiar template e personalizar
    cp "$TEMPLATES_DIR/project-template.md" "$project_file"
    
    # Substituir placeholders
    sed -i "s|\[Nome do Projeto\]|$project_name|g" "$project_file"
    sed -i "s|\[Em andamento/Concluído/Planejado\]|$project_status|g" "$project_file"
    sed -i "s|\[DD/MM/AAAA\]|$start_date|g" "$project_file"
    sed -i "s|\[Iniciante/Intermediário/Avançado\]|$project_level|g" "$project_file"
    
    print_message "$GREEN" "Projeto adicionado: $project_file"
    read -rp "Pressione Enter para continuar..."
}

# Função para adicionar bootcamp
add_bootcamp() {
    print_message "$GREEN" "=== Adicionar Novo Bootcamp ==="
    
    local area
    area=$(choose_area) || return 1
    
    echo
    read -rp "Nome do bootcamp: " bootcamp_name
    read -rp "Instituição: " bootcamp_provider
    read -rp "Data de início (DD/MM/AAAA): " start_date
    read -rp "Duração (em semanas): " bootcamp_weeks
    read -rp "Carga horária total: " bootcamp_hours
    
    # Criar nome do arquivo
    local file_name
    file_name=$(echo "$bootcamp_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
    local bootcamp_dir="$JOURNEY_DIR/$area/Bootcamps"
    local bootcamp_file="$bootcamp_dir/${start_date//\//-}_${bootcamp_provider}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$bootcamp_dir"
    
    # Copiar template e personalizar (usar template de curso como base)
    cp "$TEMPLATES_DIR/course-template.md" "$bootcamp_file"
    
    # Substituir placeholders
    sed -i "s|\[Nome do Curso\]|$bootcamp_name|g" "$bootcamp_file"
    sed -i "s|\[Nome da Instituição\]|$bootcamp_provider|g" "$bootcamp_file"
    sed -i "s|\[DD/MM/AAAA\]|$start_date|g" "$bootcamp_file"
    sed -i "s|\[XX horas\]|$bootcamp_hours horas ($bootcamp_weeks semanas)|g" "$bootcamp_file"
    sed -i "s|# \[Nome do Curso\]|# $bootcamp_name|g" "$bootcamp_file"
    
    print_message "$GREEN" "Bootcamp adicionado: $bootcamp_file"
    read -rp "Pressione Enter para continuar..."
}

# Função para adicionar workshop
add_workshop() {
    print_message "$GREEN" "=== Adicionar Novo Workshop ==="
    
    local area
    area=$(choose_area) || return 1
    
    echo
    read -rp "Nome do workshop: " workshop_name
    read -rp "Instituição/Plataforma: " workshop_provider
    read -rp "Data de realização (DD/MM/AAAA): " workshop_date
    read -rp "Duração: " workshop_duration
    read -rp "Formato (Online/Presencial): " workshop_format
    
    # Criar nome do arquivo
    local file_name
    file_name=$(echo "$workshop_name" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g')
    local workshop_dir="$JOURNEY_DIR/$area/Workshops"
    local workshop_file="$workshop_dir/${workshop_date//\//-}_${workshop_provider}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$workshop_dir"
    
    # Copiar template e personalizar (usar template de curso como base)
    cp "$TEMPLATES_DIR/course-template.md" "$workshop_file"
    
    # Substituir placeholders
    sed -i "s|\[Nome do Curso\]|$workshop_name|g" "$workshop_file"
    sed -i "s|\[Nome da Instituição\]|$workshop_provider|g" "$workshop_file"
    sed -i "s|\[DD/MM/AAAA\]|$workshop_date|g" "$workshop_file"
    sed -i "s|\[XX horas\]|$workshop_duration ($workshop_format)|g" "$workshop_file"
    sed -i "s|# \[Nome do Curso\]|# $workshop_name|g" "$workshop_file"
    
    print_message "$GREEN" "Workshop adicionado: $workshop_file"
    read -rp "Pressione Enter para continuar..."
}

# Função para listar registros
list_records() {
    print_message "$GREEN" "=== Listar Registros por Área ==="
    
    local area
    area=$(choose_area) || return 1
    
    local area_dir="$JOURNEY_DIR/$area"
    
    echo
    print_message "$BLUE" "Registros em $area:"
    echo
    
    for category in Certifications Courses Bootcamps Workshops Projects; do
        local cat_dir="$area_dir/$category"
        if [ -d "$cat_dir" ] && [ "$(ls -A "$cat_dir" 2>/dev/null)" ]; then
            print_message "$YELLOW" "$category:"
            find "$cat_dir" -name "*.md" -printf "%f\n" 2>/dev/null | sed 's/^/  - /' | sed 's/\.md$//'
            echo
        fi
    done
    
    read -rp "Pressione Enter para continuar..."
}

# Função para gerar relatório
generate_report() {
    print_message "$GREEN" "=== Relatório de Progresso ==="
    echo
    
    local total_certs=0
    local total_courses=0
    local total_projects=0
    
    print_message "$BLUE" "Resumo por Área:"
    echo
    
    for area_dir in "$JOURNEY_DIR"/*/; do
        if [ -d "$area_dir" ]; then
            area_name=$(basename "$area_dir" | sed 's/^[0-9][0-9]_//' | tr '-' ' ')
            
            local certs
            local courses
            local projects
            certs=$(find "$area_dir/Certifications" -name "*.md" 2>/dev/null | wc -l)
            courses=$(find "$area_dir/Courses" -name "*.md" 2>/dev/null | wc -l)
            projects=$(find "$area_dir/Projects" -name "*.md" 2>/dev/null | wc -l)
            
            total_certs=$((total_certs + certs))
            total_courses=$((total_courses + courses))
            total_projects=$((total_projects + projects))
            
            printf "%-20s | Cert: %2d | Cursos: %2d | Projetos: %2d\n" "$area_name" "$certs" "$courses" "$projects"
        fi
    done
    
    echo
    print_message "$YELLOW" "TOTAIS:"
    printf "Certificações: %d\n" $total_certs
    printf "Cursos: %d\n" $total_courses
    printf "Projetos: %d\n" $total_projects
    echo
    
    read -rp "Pressione Enter para continuar..."
}

# Loop principal
while true; do
    show_main_menu
    
    case $choice in
        1) add_certification ;;
        2) add_course ;;
        3) add_project ;;
        4) add_bootcamp ;;
        5) add_workshop ;;
        6) list_records ;;
        7) generate_report ;;
        8) 
            print_message "$GREEN" "Obrigado por usar o Learning Portfolio Manager!"
            exit 0
            ;;
        *) 
            print_message "$RED" "Opção inválida. Tente novamente."
            sleep 2
            ;;
    esac
done
