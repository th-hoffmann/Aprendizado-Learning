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
        course_name=$(grep "^# " "$file" | head -1 | sed 's/^# //')
        platform=$(basename "$file" | cut -d'_' -f2)
        local progress="Em andamento"
        
        # Tentar extrair progresso do arquivo
        if grep -q "Progress:" "$file" || grep -q "Progresso:" "$file"; then
            progress=$(grep -E "(Progress|Progresso):" "$file" | head -1 | cut -d':' -f2 | xargs)
        fi
        
        echo "$course_name|$platform|$progress|$area|TBD"
    fi
}

# Procurar por cursos em andamento (arquivos recentes ou com status "em andamento")
current_courses=()

for area_dir in "$LEARNING_DIR"/*; do
    if [ -d "$area_dir" ]; then
        area_name=$(basename "$area_dir" | sed 's/^[0-9][0-9]_//' | tr '-' ' ')
        
        # Procurar em todas as subcategorias
        for subdir in Courses Bootcamps Workshops; do
            if [ -d "$area_dir/$subdir" ]; then
                # Arquivos dos últimos 6 meses ou com status "em andamento"
                while IFS= read -r file; do
                    if [ -n "$file" ]; then
                        # Verificar se arquivo é recente (últimos 180 dias) ou contém "em andamento"
                        if [ "$(find "$file" -mtime -180)" ] || grep -qi "em andamento\|in progress\|ongoing" "$file" 2>/dev/null; then
                            course_info=$(extract_course_info "$file" "$area_name")
                            if [ -n "$course_info" ]; then
                                current_courses+=("$course_info")
                            fi
                        fi
                    fi
                done <<< "$(find "$area_dir/$subdir" -name "*.md" -type f 2>/dev/null)"
            fi
        done
    fi
done

# Gerar tabela para README em inglês
generate_english_table() {
    local temp_file="/tmp/current_courses_en.txt"
    
    echo "| Course | Platform | Progress | Area | Expected Completion |" > "$temp_file"
    echo "|--------|----------|----------|------|-------------------|" >> "$temp_file"
    
    if [ ${#current_courses[@]} -eq 0 ]; then
        echo "| *No courses currently active* | - | - | - | - |" >> "$temp_file"
    else
        for course in "${current_courses[@]}"; do
            IFS='|' read -r name platform progress area completion <<< "$course"
            echo "| $name | $platform | $progress | $area | $completion |" >> "$temp_file"
        done
    fi
    
    # Substituir tabela no README
    local start_line
    local end_line
    start_line=$(grep -n "| Course | Platform | Progress | Area |" "$README_FILE" | cut -d: -f1)
    end_line=$(grep -n "> 💡" "$README_FILE" | cut -d: -f1)
    
    if [ -n "$start_line" ] && [ -n "$end_line" ]; then
        # Criar arquivo temporário com a nova seção
        {
            head -n $((start_line - 1)) "$README_FILE"
            cat "$temp_file"
            echo ""
            tail -n +"$end_line" "$README_FILE"
        } > "/tmp/readme_temp.md"
        
        mv "/tmp/readme_temp.md" "$README_FILE"
    fi
    
    rm -f "$temp_file"
}

# Gerar tabela para README em português
generate_portuguese_table() {
    local temp_file="/tmp/current_courses_pt.txt"
    
    echo "| Curso | Plataforma | Progresso | Área | Conclusão Prevista |" > "$temp_file"
    echo "|-------|------------|-----------|------|-------------------|" >> "$temp_file"
    
    if [ ${#current_courses[@]} -eq 0 ]; then
        echo "| *Nenhum curso ativo no momento* | - | - | - | - |" >> "$temp_file"
    else
        for course in "${current_courses[@]}"; do
            IFS='|' read -r name platform progress area completion <<< "$course"
            echo "| $name | $platform | $progress | $area | $completion |" >> "$temp_file"
        done
    fi
    
    # Substituir tabela no README português se existir
    if [ -f "$README_PT_FILE" ]; then
        local start_line
        local end_line
        start_line=$(grep -n "| Curso | Plataforma | Progresso |" "$README_PT_FILE" | cut -d: -f1)
        end_line=$(grep -n "> 💡" "$README_PT_FILE" | cut -d: -f1)
        
        if [ -n "$start_line" ] && [ -n "$end_line" ]; then
            {
                head -n $((start_line - 1)) "$README_PT_FILE"
                cat "$temp_file"
                echo ""
                tail -n +"$end_line" "$README_PT_FILE"
            } > "/tmp/readme_pt_temp.md"
            
            mv "/tmp/readme_pt_temp.md" "$README_PT_FILE"
        fi
    fi
    
    rm -f "$temp_file"
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
