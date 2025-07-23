#!/bin/bash

# Script para atualizar seção "Currently Learning" nos READMEs
# Usage: ./update-current-courses.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
README_FILE="$SCRIPT_DIR/../../README.md"
README_PT_FILE="$SCRIPT_DIR/../../README_pt-br.md"
LEARNING_DIR="$SCRIPT_DIR/../../Learning-Journey"

echo "🔄 Atualizando seção 'Currently Learning'..."

# Função para extrair informações de cursos em andamento
extract_course_info() {
    local file="$1"
    local area="$2"
    
    if [ -f "$file" ]; then
        local course_name
        local platform
        local status
        course_name=$(grep "^# " "$file" | head -1 | sed 's/^# //')
        platform=$(grep -m 1 -i "Instituição:" "$file" | cut -d':' -f2 | xargs)
        status=$(grep -m 1 -i "Status:" "$file" | cut -d':' -f2 | xargs)
        
        # Fallback para compatibilidade com arquivos antigos
        if [ -z "$platform" ]; then
            platform=$(basename "$file" | cut -d'_' -f2)
        fi
        if [ -z "$status" ]; then
            status="Em andamento"
        fi
        
        echo "$course_name|$platform|$status|$area|TBD"
    fi
}

# Procurar por cursos com status "em andamento"
current_courses=()

for area_dir in "$LEARNING_DIR"/*; do
    if [ -d "$area_dir" ]; then
        area_name=$(basename "$area_dir" | sed 's/^[0-9][0-9]_//' | tr '-' ' ')
        
        for subdir in Courses Bootcamps Workshops; do
            if [ -d "$area_dir/$subdir" ]; then
                # A fonte da verdade é o status dentro do arquivo.
                while IFS= read -r file; do
                    course_info=$(extract_course_info "$file" "$area_name")
                    [ -n "$course_info" ] && current_courses+=("$course_info")
                done <<< "$(grep -rli -E "status:.*(em andamento|in progress|ongoing)" "$area_dir/$subdir")"
            fi
        done
    fi
done

# Gerar tabela para README em inglês
generate_english_table() {
    local temp_table
    temp_table=$(mktemp)
    local start_marker="<!-- CURRENT_COURSES_START -->"
    local end_marker="<!-- CURRENT_COURSES_END -->"
    
    echo "| Course | Platform | Progress | Area | Expected Completion |" > "$temp_table"
    echo "|--------|----------|----------|------|-------------------|" >> "$temp_table"
    
    if [ ${#current_courses[@]} -eq 0 ]; then
        echo "| *No courses currently active* | - | - | - | - |" >> "$temp_table"
    else
        for course in "${current_courses[@]}"; do
            IFS='|' read -r name platform progress area completion <<< "$course"
            echo "| $name | $platform | $progress | $area | $completion |" >> "$temp_table"
        done
    fi
    
    # Substituir conteúdo entre os marcadores de forma segura
    local temp_readme
    temp_readme=$(mktemp)
    awk -v s="$start_marker" -v e="$end_marker" -v r="$temp_table" \
        'BEGIN{p=1} $0~s{print; print ""; system("cat "r); p=0} $0~e{p=1} p' "$README_FILE" > "$temp_readme"
    if [ -s "$temp_readme" ]; then
        mv "$temp_readme" "$README_FILE"
    else
        rm "$temp_readme"
    fi
    rm "$temp_table"
}

# Gerar tabela para README em português
generate_portuguese_table() {
    local temp_table
    temp_table=$(mktemp)
    local start_marker="<!-- CURRENT_COURSES_START -->"
    local end_marker="<!-- CURRENT_COURSES_END -->"
    
    echo "| Curso | Plataforma | Progresso | Área | Conclusão Prevista |" > "$temp_table"
    echo "|-------|------------|-----------|------|-------------------|" >> "$temp_table"
    
    if [ ${#current_courses[@]} -eq 0 ]; then
        echo "| *Nenhum curso ativo no momento* | - | - | - | - |" >> "$temp_table"
    else
        for course in "${current_courses[@]}"; do
            IFS='|' read -r name platform progress area completion <<< "$course"
            echo "| $name | $platform | $progress | $area | $completion |" >> "$temp_table"
        done
    fi
    
    # Substituir tabela no README português se existir
    if [ -f "$README_PT_FILE" ]; then
        local temp_readme
        temp_readme=$(mktemp)
        awk -v s="$start_marker" -v e="$end_marker" -v r="$temp_table" \
            'BEGIN{p=1} $0~s{print; print ""; system("cat "r); p=0} $0~e{p=1} p' "$README_PT_FILE" > "$temp_readme"
        if [ -s "$temp_readme" ]; then
            mv "$temp_readme" "$README_PT_FILE"
        else
            rm "$temp_readme"
        fi
    fi
    rm "$temp_table"
}

# Executar atualizações
generate_english_table
generate_portuguese_table

# Relatório
echo "📊 Cursos em andamento encontrados: ${#current_courses[@]}"
for course in "${current_courses[@]}"; do
    IFS='|' read -r name platform progress area completion <<< "$course"
    echo "  📚 [$area] $name ($platform) - $progress"
done

echo "✅ Seção 'Currently Learning' atualizada com sucesso!"

# Sugestão de automatização
echo ""
echo "💡 Dica: Execute este script regularmente para manter a seção atualizada"
echo "   Adicione ao cron para execução automática:"
echo "   0 0 * * 1 cd /path/to/repo && ./Resources/Scripts/update-current-courses.sh"
