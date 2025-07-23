#!/bin/bash

# Script para atualizar estatísticas automáticas nos READMEs principais
# Usage: ./update-stats.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
README_FILE="$SCRIPT_DIR/../../README.md"
README_PT_FILE="$SCRIPT_DIR/../../README_pt-br.md"
LEARNING_DIR="$SCRIPT_DIR/../../Learning-Journey"

echo "Atualizando estatísticas do repositório..."

# Função para contar arquivos por tipo
count_files() {
    local dir="$1"
    local pattern="$2"
    
    if [ -d "$dir" ]; then
        find "$dir" -name "*$pattern*" -type f | wc -l
    else
        echo "0"
    fi
}

# Contar todos os tipos de atividades
cert_count=0
course_count=0  
project_count=0
bootcamp_count=0
workshop_count=0
area_count=6

# Função para detectar tipo de atividade pelo diretório
get_activity_type() {
    local file_path="$1"
    local parent_dir
    parent_dir=$(basename "$(dirname "$file_path")")
    
    case "$parent_dir" in
        "Certifications") echo "certification" ;;
        "Courses") echo "course" ;;
        "Projects") echo "project" ;;
        "Bootcamps") echo "bootcamp" ;;
        "Workshops") echo "workshop" ;;
        *) echo "unknown" ;;
    esac
}

# Função para atualizar um badge de contagem de forma robusta
update_badge_count() {
    local file="$1"
    local prefix="$2"
    local count="$3"
    # Regex que encontra o prefixo, um hífen, e um ou mais dígitos. Substitui apenas os dígitos.
    sed -i -E "s/(${prefix}-)[0-9]+/\1${count}/g" "$file"
}

# Percorrer todas as áreas de aprendizado
for area_dir in "$LEARNING_DIR"/*; do
    if [ -d "$area_dir" ]; then
        # Encontrar todos os arquivos .md (exceto READMEs)
        while IFS= read -r file; do
            if [ -n "$file" ]; then
                activity_type=$(get_activity_type "$file")
                
                case "$activity_type" in
                    "certification") cert_count=$((cert_count + 1)) ;;
                    "course") course_count=$((course_count + 1)) ;;
                    "project") project_count=$((project_count + 1)) ;;
                    "bootcamp") bootcamp_count=$((bootcamp_count + 1)) ;;
                    "workshop") workshop_count=$((workshop_count + 1)) ;;
                esac
            fi
        done <<< "$(find "$area_dir" -name "*.md" -type f | grep -v README)"
        
        # Contar atividades totais por área
        area_name=$(basename "$area_dir" | sed 's/^[0-9][0-9]_//' | tr '-' ' ')
        total_activities=$(find "$area_dir" -name "*.md" -not -name "README*" | wc -l)
        
        echo "Área $area_name: $total_activities atividades"

        # Atualizar badges de área em ambos os READMEs de forma robusta
        area_badge_prefix=$(echo "$area_name" | tr ' ' '%')
        # Regex que lida com singular/plural e ambos os idiomas (Activity/Atividade)
        sed -i -E "s/(${area_badge_prefix}-)[0-9]+(%20(Activity|Atividade)s?)/\1${total_activities}\2/g" "$README_FILE"
        sed -i -E "s/(${area_badge_prefix}-)[0-9]+(%20(Activity|Atividade)s?)/\1${total_activities}\2/g" "$README_PT_FILE"
    fi
done

# Atualizar badges principais (README inglês)
update_badge_count "$README_FILE" "Certifications" "$cert_count"
update_badge_count "$README_FILE" "Courses" "$course_count"
update_badge_count "$README_FILE" "Projects" "$project_count"
update_badge_count "$README_FILE" "Learning%20Areas" "$area_count"

# Atualizar badges principais (README português)
update_badge_count "$README_PT_FILE" "Certifications" "$cert_count"
update_badge_count "$README_PT_FILE" "Courses" "$course_count"
update_badge_count "$README_PT_FILE" "Projects" "$project_count"
update_badge_count "$README_PT_FILE" "Learning%20Areas" "$area_count"

echo "Estatísticas atualizadas:"
echo "- Certificações: $cert_count"
echo "- Cursos: $course_count"
echo "- Projetos: $project_count"
echo "- Bootcamps: $bootcamp_count"
echo "- Workshops: $workshop_count"
echo "- Áreas de Aprendizado: $area_count"
echo "✅ READMEs atualizados com sucesso!"
