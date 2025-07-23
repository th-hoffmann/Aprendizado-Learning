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
    # Prompts devem ir para stderr para não serem capturados pela substituição de comando `var=$(...)`
    echo >&2
    print_message "$YELLOW" "Áreas disponíveis:" >&2
    echo "1) DevOps" >&2
    echo "2) Cloud Computing" >&2
    echo "3) Security" >&2
    echo "4) Linux Infrastructure" >&2
    echo "5) Programming" >&2
    echo "6) Data Science" >&2
    echo >&2
    read -rp "Escolha a área (1-6): " area_choice # O prompt de read -p já vai para stderr
    
    case $area_choice in
        1) echo "01_DevOps" ;;
        2) echo "02_Cloud-Computing" ;;
        3) echo "03_Security" ;;
        4) echo "04_Linux-Infrastructure" ;;
        5) echo "05_Programming" ;;
        6) echo "06_Data-Science" ;;
        *) print_message "$RED" "Opção inválida" >&2; return 1 ;;
    esac
}

# Função para criar um nome de arquivo limpo e padronizado
create_sanitized_filename() {
    local input_string="$1"
    echo "$input_string" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/[^a-z0-9-]//g'
}

# Função para preencher a seção de tecnologias em um arquivo de template
fill_technologies_section() {
    local file_path="$1"
    local technologies_string="$2"
    local placeholder_text="$3"

    local tech_placeholder_comment="<!-- TECHNOLOGIES_PLACEHOLDER -->"
    if grep -q "\[$placeholder_text" "$file_path"; then
        sed -i "/- \[$placeholder_text/i $tech_placeholder_comment" "$file_path"
        sed -i "/- \[$placeholder_text.*\]/d" "$file_path"
    fi

    if [ -n "$technologies_string" ]; then
        local tech_list_formatted
        tech_list_formatted=$(echo "$technologies_string" | sed 's/, */\n- /g' | sed 's/^/- /')
        
        local temp_tech_file
        temp_tech_file=$(mktemp)
        echo "$tech_list_formatted" > "$temp_tech_file"
        sed -i -e "/${tech_placeholder_comment}/r ${temp_tech_file}" "$file_path"
        rm "$temp_tech_file"
    fi
    sed -i "/${tech_placeholder_comment}/d" "$file_path" # Remove o marcador
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
    read -rp "Link de verificação: " cert_link
    read -rp "Principais tecnologias (separadas por vírgula): " cert_techs
    read -rp "ID da credencial: " cert_id
    
    # Criar nome do arquivo
    local file_name
    file_name=$(create_sanitized_filename "$cert_name")
    local cert_dir="$JOURNEY_DIR/$area/Certifications"
    local cert_file="$cert_dir/${cert_date//\//-}_${cert_provider}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$cert_dir"
    
    # Copiar template e personalizar
    cp "$TEMPLATES_DIR/certification-template.md" "$cert_file"
    
    # Substituir placeholders
    sed -i "s#\[Nome da Certificação\]#$cert_name#g" "$cert_file"
    sed -i "s#\[Nome da Certificadora\]#$cert_provider#g" "$cert_file"
    sed -i "s#\[DD/MM/AAAA\]#$cert_date#g" "$cert_file"
    sed -i "s#\[ID único da credencial\]#$cert_id#g" "$cert_file"
    sed -i "s#\[Link de Verificação\]#$cert_link#g" "$cert_file"
    
    # Preencher seção de tecnologias usando a função auxiliar
    fill_technologies_section "$cert_file" "$cert_techs" "Tecnologia/Ferramenta 1"
    
    # Aplicar badges personalizados
    enhance_certification_template "$cert_file" "$cert_provider" "$cert_name" "$area" "$cert_date" "$cert_techs"
    
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
    read -rp "Status (Em andamento/Concluído): " course_status
    read -rp "Instrutor(es): " course_instructor
    read -rp "Modalidade (Online/Presencial/Híbrido): " course_modality
    read -rp "Link para o curso: " course_link
    read -rp "Principais tecnologias (separadas por vírgula): " course_techs
    read -rp "Carga horária: " course_hours
    
    # Criar nome do arquivo
    local file_name
    file_name=$(create_sanitized_filename "$course_name")
    local course_dir="$JOURNEY_DIR/$area/Courses"
    local course_file="$course_dir/${start_date//\//-}_${course_provider}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$course_dir"
    
    # Copiar template e personalizar
    cp "$TEMPLATES_DIR/course-template.md" "$course_file"
    
    # Substituir placeholders
    sed -i "s#\[Nome do Curso\]#$course_name#g" "$course_file"
    sed -i "s#\[Nome da Instituição\]#$course_provider#g" "$course_file"
    sed -i "s#\[Nome do(s) Instrutor(es)\]#$course_instructor#g" "$course_file"
    sed -i "s#\[DD/MM/AAAA\]#$start_date#g" "$course_file"
    sed -i "s#\[Concluído/Em andamento\]#$course_status#g" "$course_file"
    sed -i "s#\[Presencial/Online/Híbrido\]#$course_modality#g" "$course_file"
    sed -i "s#\[Link do Curso\]#$course_link#g" "$course_file"
    sed -i "s#\[XX horas\]#$course_hours horas#g" "$course_file"

    # Preencher seção de tecnologias usando a função auxiliar
    fill_technologies_section "$course_file" "$course_techs" "Tecnologia/Ferramenta 1"
    
    # Aplicar badges personalizados baseados na plataforma e conteúdo
    enhance_course_template "$course_file" "$course_provider" "$course_name" "$area" "$course_techs" "$course_status"
    
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
    read -rp "URL do repositório (GitHub, etc.): " project_repo
    read -rp "URL da demo/aplicação online: " project_demo
    read -rp "Principais tecnologias (separadas por vírgula): " project_techs
    
    # Criar nome do arquivo
    local file_name
    file_name=$(create_sanitized_filename "$project_name")
    local project_dir="$JOURNEY_DIR/$area/Projects"
    local project_file="$project_dir/${start_date//\//-}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$project_dir"
    
    # Copiar template e personalizar
    cp "$TEMPLATES_DIR/project-template.md" "$project_file"
    
    # Substituir placeholders
    sed -i "s#\[Nome do Projeto\]#$project_name#g" "$project_file"
    sed -i "s#\[Em andamento/Concluído/Planejado\]#$project_status#g" "$project_file"
    sed -i "s#\[DD/MM/AAAA\]#$start_date#g" "$project_file"
    sed -i "s#\[Iniciante/Intermediário/Avançado\]#$project_level#g" "$project_file"
    sed -i "s#\[URL do repositório\]#$project_repo#g" "$project_file"
    sed -i "s#\[URL da aplicação em funcionamento\]#$project_demo#g" "$project_file"
    
    # Preencher seção de tecnologias usando a função auxiliar
    fill_technologies_section "$project_file" "$project_techs" "Tecnologia 1"
    
    # Aplicar badges personalizados
    enhance_project_template "$project_file" "$project_name" "$project_status" "$project_level" "$area" "$project_techs"

    print_message "$GREEN" "Projeto adicionado com badges: $project_file"
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
    read -rp "Status (Em andamento/Concluído): " bootcamp_status
    read -rp "Instrutor(es): " bootcamp_instructor
    read -rp "Modalidade (Online/Presencial/Híbrido): " bootcamp_modality
    read -rp "Link para o curso: " bootcamp_link
    read -rp "Duração (em semanas): " bootcamp_weeks
    read -rp "Principais tecnologias (separadas por vírgula): " bootcamp_techs
    read -rp "Carga horária total: " bootcamp_hours
    
    # Criar nome do arquivo
    local file_name
    file_name=$(create_sanitized_filename "$bootcamp_name")
    local bootcamp_dir="$JOURNEY_DIR/$area/Bootcamps"
    local bootcamp_file="$bootcamp_dir/${start_date//\//-}_${bootcamp_provider}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$bootcamp_dir"
    
    # Copiar template e personalizar (usar template de curso como base)
    cp "$TEMPLATES_DIR/course-template.md" "$bootcamp_file"
    
    # Substituir placeholders
    sed -i "s#\[Nome do Curso\]#$bootcamp_name#g" "$bootcamp_file"
    sed -i "s#\[Nome da Instituição\]#$bootcamp_provider#g" "$bootcamp_file"
    sed -i "s#\[Nome do(s) Instrutor(es)\]#$bootcamp_instructor#g" "$bootcamp_file"
    sed -i "s#\[DD/MM/AAAA\]#$start_date#g" "$bootcamp_file"
    sed -i "s#\[Concluído/Em andamento\]#$bootcamp_status#g" "$bootcamp_file"
    sed -i "s#\[Presencial/Online/Híbrido\]#$bootcamp_modality#g" "$bootcamp_file"
    sed -i "s#\[Link do Curso\]#$bootcamp_link#g" "$bootcamp_file"
    sed -i "s#\[XX horas\]#$bootcamp_hours horas ($bootcamp_weeks semanas)#g" "$bootcamp_file"

    # Preencher seção de tecnologias usando a função auxiliar
    fill_technologies_section "$bootcamp_file" "$bootcamp_techs" "Tecnologia/Ferramenta 1"
    
    # Aplicar badges personalizados
    enhance_course_template "$bootcamp_file" "$bootcamp_provider" "$bootcamp_name" "$area" "$bootcamp_techs" "$bootcamp_status"
    
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
    read -rp "Status (Em andamento/Concluído): " workshop_status
    read -rp "Instrutor(es): " workshop_instructor
    read -rp "Link para o workshop: " workshop_link
    read -rp "Principais tecnologias (separadas por vírgula): " workshop_techs
    read -rp "Carga horária: " workshop_hours
    read -rp "Modalidade (Online/Presencial/Híbrido): " workshop_modality
    
    # Criar nome do arquivo
    local file_name
    file_name=$(create_sanitized_filename "$workshop_name")
    local workshop_dir="$JOURNEY_DIR/$area/Workshops"
    local workshop_file="$workshop_dir/${workshop_date//\//-}_${workshop_provider}_${file_name}.md"
    
    # Criar diretório se não existir
    mkdir -p "$workshop_dir"
    
    # Copiar template e personalizar (usar template de curso como base)
    cp "$TEMPLATES_DIR/course-template.md" "$workshop_file"
    
    # Substituir placeholders
    sed -i "s#\[Nome do Curso\]#$workshop_name#g" "$workshop_file"
    sed -i "s#\[Nome da Instituição\]#$workshop_provider#g" "$workshop_file"
    sed -i "s#\[Nome do(s) Instrutor(es)\]#$workshop_instructor#g" "$workshop_file"
    sed -i "s#\[DD/MM/AAAA\]#$workshop_date#g" "$workshop_file"
    sed -i "s#\[Concluído/Em andamento\]#$workshop_status#g" "$workshop_file"
    sed -i "s#\[XX horas\]#$workshop_hours#g" "$workshop_file"
    sed -i "s#\[Presencial/Online/Híbrido\]#$workshop_modality#g" "$workshop_file"
    sed -i "s#\[Link do Curso\]#$workshop_link#g" "$workshop_file"

    # Preencher seção de tecnologias usando a função auxiliar
    fill_technologies_section "$workshop_file" "$workshop_techs" "Tecnologia/Ferramenta 1"
    
    # Aplicar badges personalizados
    enhance_course_template "$workshop_file" "$workshop_provider" "$workshop_name" "$area" "$workshop_techs" "$workshop_status"
    
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
    local total_bootcamps=0
    local total_workshops=0
    local total_projects=0
    
    print_message "$BLUE" "Resumo por Área:"
    echo
    
    for area_dir in "$JOURNEY_DIR"/*/; do
        if [ -d "$area_dir" ]; then
            area_name=$(basename "$area_dir" | sed 's/^[0-9][0-9]_//' | tr '-' ' ')
            
            local certs
            local courses
            local bootcamps
            local workshops
            local projects
            certs=$(find "$area_dir/Certifications" -name "*.md" 2>/dev/null | wc -l)
            courses=$(find "$area_dir/Courses" -name "*.md" 2>/dev/null | wc -l)
            bootcamps=$(find "$area_dir/Bootcamps" -name "*.md" 2>/dev/null | wc -l)
            workshops=$(find "$area_dir/Workshops" -name "*.md" 2>/dev/null | wc -l)
            projects=$(find "$area_dir/Projects" -name "*.md" 2>/dev/null | wc -l)
            
            total_certs=$((total_certs + certs))
            total_courses=$((total_courses + courses))
            total_bootcamps=$((total_bootcamps + bootcamps))
            total_workshops=$((total_workshops + workshops))
            total_projects=$((total_projects + projects))
            
            printf "%-20s | Certs: %2d | Cursos: %2d | Bootcamps: %2d | Workshops: %2d | Projetos: %2d\n" \
                "$area_name" "$certs" "$courses" "$bootcamps" "$workshops" "$projects"
        fi
    done
    
    echo
    print_message "$YELLOW" "TOTAIS:"
    printf "Certificações: %d\n" $total_certs
    printf "Cursos: %d\n" $total_courses
    printf "Bootcamps: %d\n" $total_bootcamps
    printf "Workshops: %d\n" $total_workshops
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
