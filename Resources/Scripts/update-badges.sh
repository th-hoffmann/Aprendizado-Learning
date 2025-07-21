#!/bin/bash

# Auto-Update Portfolio Badges
# Script para atualizar automaticamente badges nos READMEs

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
JOURNEY_DIR="$REPO_ROOT/Learning-Journey"

# Função para contar arquivos
count_files() {
    local dir="$1"
    if [ -d "$dir" ]; then
        find "$dir" -name "*.md" 2>/dev/null | wc -l
    else
        echo "0"
    fi
}

# Função para gerar badges atualizados
generate_updated_badges() {
    local total_certs=0
    local total_courses=0
    local total_projects=0
    local total_bootcamps=0
    local total_workshops=0
    
    # Contar por área
    declare -A area_stats
    
    for area_dir in "$JOURNEY_DIR"/*/; do
        if [ -d "$area_dir" ]; then
            area_name=$(basename "$area_dir")
            
            local certs=$(count_files "$area_dir/Certifications")
            local courses=$(count_files "$area_dir/Courses")
            local projects=$(count_files "$area_dir/Projects")
            local bootcamps=$(count_files "$area_dir/Bootcamps")
            local workshops=$(count_files "$area_dir/Workshops")
            
            total_certs=$((total_certs + certs))
            total_courses=$((total_courses + courses))
            total_projects=$((total_projects + projects))
            total_bootcamps=$((total_bootcamps + bootcamps))
            total_workshops=$((total_workshops + workshops))
            
            area_stats["$area_name"]="$certs,$courses,$projects,$bootcamps,$workshops"
        fi
    done
    
    # Gerar badges shield.io
    local badges=$(cat << EOF
<!-- Auto-generated badges -->
[![Certifications](https://img.shields.io/badge/Certifications-$total_certs-success?style=flat-square&logo=certificate)](./Learning-Journey)
[![Courses](https://img.shields.io/badge/Courses-$total_courses-blue?style=flat-square&logo=book)](./Learning-Journey)
[![Projects](https://img.shields.io/badge/Projects-$total_projects-orange?style=flat-square&logo=code)](./Learning-Journey)
[![Learning Areas](https://img.shields.io/badge/Learning%20Areas-6-purple?style=flat-square&logo=target)](./Learning-Journey)
[![Last Updated](https://img.shields.io/badge/Last%20Updated-$(date '+%B%20%Y')-lightgrey?style=flat-square&logo=calendar)](./Resources/Assets/badges/dashboard.md)
EOF
)

    # Gerar cards HTML atualizados
    local html_cards=""
    
    # DevOps
    local devops_total=0
    if [[ -n "${area_stats['01_DevOps']}" ]]; then
        IFS=',' read -r c co p b w <<< "${area_stats['01_DevOps']}"
        devops_total=$((c + co + p + b + w))
    fi
    
    html_cards+=$(cat << EOF

  <!-- DevOps Badge -->
  <div style="background: linear-gradient(135deg, #ff7e5f, #feb47b); color: white; padding: 20px; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    <div style="font-size: 30px; margin-bottom: 10px;">🔧</div>
    <h3 style="margin: 0; font-size: 16px;">DevOps</h3>
    <p style="margin: 5px 0; opacity: 0.9;">$devops_total Atividades</p>
    <p style="margin: 0; font-size: 12px;">CI/CD • IaC • Containers</p>
  </div>
EOF
)

    # Cloud Computing
    local cloud_total=0
    if [[ -n "${area_stats['02_Cloud-Computing']}" ]]; then
        IFS=',' read -r c co p b w <<< "${area_stats['02_Cloud-Computing']}"
        cloud_total=$((c + co + p + b + w))
    fi
    
    html_cards+=$(cat << EOF
  
  <!-- Cloud Badge -->
  <div style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 20px; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    <div style="font-size: 30px; margin-bottom: 10px;">☁️</div>
    <h3 style="margin: 0; font-size: 16px;">Cloud Computing</h3>
    <p style="margin: 5px 0; opacity: 0.9;">$cloud_total Atividades</p>
    <p style="margin: 0; font-size: 12px;">AWS • Azure • GCP</p>
  </div>
EOF
)

    # Security
    local security_total=0
    if [[ -n "${area_stats['03_Security']}" ]]; then
        IFS=',' read -r c co p b w <<< "${area_stats['03_Security']}"
        security_total=$((c + co + p + b + w))
    fi
    
    html_cards+=$(cat << EOF
  
  <!-- Security Badge -->
  <div style="background: linear-gradient(135deg, #f093fb, #f5576c); color: white; padding: 20px; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    <div style="font-size: 30px; margin-bottom: 10px;">🔒</div>
    <h3 style="margin: 0; font-size: 16px;">Security</h3>
    <p style="margin: 5px 0; opacity: 0.9;">$security_total Atividades</p>
    <p style="margin: 0; font-size: 12px;">CompTIA • CISSP • DevSecOps</p>
  </div>
EOF
)

    # Linux
    local linux_total=0
    if [[ -n "${area_stats['04_Linux-Infrastructure']}" ]]; then
        IFS=',' read -r c co p b w <<< "${area_stats['04_Linux-Infrastructure']}"
        linux_total=$((c + co + p + b + w))
    fi
    
    html_cards+=$(cat << EOF
  
  <!-- Linux Badge -->
  <div style="background: linear-gradient(135deg, #4facfe, #00f2fe); color: white; padding: 20px; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    <div style="font-size: 30px; margin-bottom: 10px;">🐧</div>
    <h3 style="margin: 0; font-size: 16px;">Linux Infrastructure</h3>
    <p style="margin: 5px 0; opacity: 0.9;">$linux_total Atividades</p>
    <p style="margin: 0; font-size: 12px;">RHCE • LPIC • Ubuntu</p>
  </div>
EOF
)

    # Programming
    local prog_total=0
    if [[ -n "${area_stats['05_Programming']}" ]]; then
        IFS=',' read -r c co p b w <<< "${area_stats['05_Programming']}"
        prog_total=$((c + co + p + b + w))
    fi
    
    html_cards+=$(cat << EOF
  
  <!-- Programming Badge -->
  <div style="background: linear-gradient(135deg, #43e97b, #38f9d7); color: white; padding: 20px; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    <div style="font-size: 30px; margin-bottom: 10px;">💻</div>
    <h3 style="margin: 0; font-size: 16px;">Programming</h3>
    <p style="margin: 5px 0; opacity: 0.9;">$prog_total Atividades</p>
    <p style="margin: 0; font-size: 12px;">Python • JavaScript • Go</p>
  </div>
EOF
)

    # Data Science
    local data_total=0
    if [[ -n "${area_stats['06_Data-Science']}" ]]; then
        IFS=',' read -r c co p b w <<< "${area_stats['06_Data-Science']}"
        data_total=$((c + co + p + b + w))
    fi
    
    html_cards+=$(cat << EOF
  
  <!-- Data Science Badge -->
  <div style="background: linear-gradient(135deg, #fa709a, #fee140); color: white; padding: 20px; border-radius: 15px; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
    <div style="font-size: 30px; margin-bottom: 10px;">📊</div>
    <h3 style="margin: 0; font-size: 16px;">Data Science</h3>
    <p style="margin: 5px 0; opacity: 0.9;">$data_total Atividades</p>
    <p style="margin: 0; font-size: 12px;">ML • Analytics • Visualization</p>
  </div>
  
</div>

| Categoria | Quantidade | Mais Recente |
|-----------|------------|--------------|
| Certificações | $total_certs | - |
| Cursos | $total_courses | - |
| Projetos | $total_projects | - |
EOF
)

    # Combinar tudo
    echo "$badges"
    echo
    echo '<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin: 20px 0;">'
    echo "$html_cards"
}

# Função para atualizar README
update_readme() {
    local readme_file="$1"
    local temp_file=$(mktemp)
    local in_stats_section=false
    local stats_start_found=false
    
    # Ler arquivo linha por linha
    while IFS= read -r line; do
        if [[ "$line" == "## 🏆 Estatísticas Rápidas" ]]; then
            echo "$line" >> "$temp_file"
            echo >> "$temp_file"
            generate_updated_badges >> "$temp_file"
            echo >> "$temp_file"
            in_stats_section=true
            stats_start_found=true
        elif $in_stats_section && [[ "$line" =~ ^##\  ]]; then
            # Nova seção encontrada, parar de pular linhas
            in_stats_section=false
            echo "$line" >> "$temp_file"
        elif ! $in_stats_section; then
            echo "$line" >> "$temp_file"
        fi
    done < "$readme_file"
    
    # Substituir arquivo original
    mv "$temp_file" "$readme_file"
    
    if $stats_start_found; then
        echo "✅ $readme_file atualizado com sucesso!"
    else
        echo "⚠️  Seção de estatísticas não encontrada em $readme_file"
    fi
}

# Função principal
main() {
    echo "🔄 Atualizando badges do portfólio..."
    echo
    
    # Gerar dashboard atualizado usando update-stats.sh (mais moderno)
    "$SCRIPT_DIR/update-stats.sh"
    echo
    
    # Atualizar READMEs
    update_readme "$REPO_ROOT/README_pt-br.md"
    update_readme "$REPO_ROOT/README.md"
    
    echo
    echo "✨ Atualização de badges concluída!"
    echo "📊 Execute 'git diff' para ver as mudanças"
}

# Executar
main
