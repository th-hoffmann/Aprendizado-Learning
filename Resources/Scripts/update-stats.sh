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
        
        # Atualizar badges por área no README inglês
        case "$area_name" in
            "DevOps")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/DevOps-[0-9]*%20Activity/DevOps-${total_activities}%20Activity/" "$README_FILE"
                else
                    sed -i "s/DevOps-[0-9]*%20Activities\?/DevOps-${total_activities}%20Activities/" "$README_FILE"
                fi
                ;;
            "Cloud Computing")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Cloud%20Computing-[0-9]*%20Activity/Cloud%20Computing-${total_activities}%20Activity/" "$README_FILE"
                else
                    sed -i "s/Cloud%20Computing-[0-9]*%20Activities\?/Cloud%20Computing-${total_activities}%20Activities/" "$README_FILE"
                fi
                ;;
            "Security")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Security-[0-9]*%20Activity/Security-${total_activities}%20Activity/" "$README_FILE"
                else
                    sed -i "s/Security-[0-9]*%20Activities\?/Security-${total_activities}%20Activities/" "$README_FILE"
                fi
                ;;
            "Linux Infrastructure")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Linux%20Infrastructure-[0-9]*%20Activity/Linux%20Infrastructure-${total_activities}%20Activity/" "$README_FILE"
                else
                    sed -i "s/Linux%20Infrastructure-[0-9]*%20Activities\?/Linux%20Infrastructure-${total_activities}%20Activities/" "$README_FILE"
                fi
                ;;
            "Programming")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Programming-[0-9]*%20Activity/Programming-${total_activities}%20Activity/" "$README_FILE"
                else
                    sed -i "s/Programming-[0-9]*%20Activities\?/Programming-${total_activities}%20Activities/" "$README_FILE"
                fi
                ;;
            "Data Science")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Data%20Science-[0-9]*%20Activity/Data%20Science-${total_activities}%20Activity/" "$README_FILE"
                else
                    sed -i "s/Data%20Science-[0-9]*%20Activities\?/Data%20Science-${total_activities}%20Activities/" "$README_FILE"
                fi
                ;;
        esac
        
        # Atualizar badges por área no README português
        case "$area_name" in
            "DevOps")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/DevOps-[0-9]*%20Atividade/DevOps-${total_activities}%20Atividade/" "$README_PT_FILE"
                else
                    sed -i "s/DevOps-[0-9]*%20Atividades\?/DevOps-${total_activities}%20Atividades/" "$README_PT_FILE"
                fi
                ;;
            "Cloud Computing")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Cloud%20Computing-[0-9]*%20Atividade/Cloud%20Computing-${total_activities}%20Atividade/" "$README_PT_FILE"
                else
                    sed -i "s/Cloud%20Computing-[0-9]*%20Atividades\?/Cloud%20Computing-${total_activities}%20Atividades/" "$README_PT_FILE"
                fi
                ;;
            "Security")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Security-[0-9]*%20Atividade/Security-${total_activities}%20Atividade/" "$README_PT_FILE"
                else
                    sed -i "s/Security-[0-9]*%20Atividades\?/Security-${total_activities}%20Atividades/" "$README_PT_FILE"
                fi
                ;;
            "Linux Infrastructure")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Linux%20Infrastructure-[0-9]*%20Atividade/Linux%20Infrastructure-${total_activities}%20Atividade/" "$README_PT_FILE"
                else
                    sed -i "s/Linux%20Infrastructure-[0-9]*%20Atividades\?/Linux%20Infrastructure-${total_activities}%20Atividades/" "$README_PT_FILE"
                fi
                ;;
            "Programming")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Programming-[0-9]*%20Atividade/Programming-${total_activities}%20Atividade/" "$README_PT_FILE"
                else
                    sed -i "s/Programming-[0-9]*%20Atividades\?/Programming-${total_activities}%20Atividades/" "$README_PT_FILE"
                fi
                ;;
            "Data Science")
                if [ "$total_activities" -eq 1 ]; then
                    sed -i "s/Data%20Science-[0-9]*%20Atividade/Data%20Science-${total_activities}%20Atividade/" "$README_PT_FILE"
                else
                    sed -i "s/Data%20Science-[0-9]*%20Atividades\?/Data%20Science-${total_activities}%20Atividades/" "$README_PT_FILE"
                fi
                ;;
        esac
    fi
done

# Atualizar badges principais (README inglês)
sed -i "s/Certifications-[0-9]*/Certifications-$cert_count/" "$README_FILE"
sed -i "s/Courses-[0-9]*/Courses-$course_count/" "$README_FILE"
sed -i "s/Projects-[0-9]*/Projects-$project_count/" "$README_FILE"
sed -i "s/Learning%20Areas-[0-9]*/Learning%20Areas-$area_count/" "$README_FILE"

# Atualizar badges principais (README português)
sed -i "s/Certifications-[0-9]*/Certifications-$cert_count/" "$README_PT_FILE"
sed -i "s/Courses-[0-9]*/Courses-$course_count/" "$README_PT_FILE"
sed -i "s/Projects-[0-9]*/Projects-$project_count/" "$README_PT_FILE"
sed -i "s/Learning%20Areas-[0-9]*/Learning%20Areas-$area_count/" "$README_PT_FILE"

echo "Estatísticas atualizadas:"
echo "- Certificações: $cert_count"
echo "- Cursos: $course_count"
echo "- Projetos: $project_count"
echo "- Bootcamps: $bootcamp_count"
echo "- Workshops: $workshop_count"
echo "- Áreas de Aprendizado: $area_count"
echo "✅ READMEs atualizados com sucesso!"
