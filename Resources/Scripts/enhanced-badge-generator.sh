#!/bin/bash

# Enhanced Badge Generator
# Sistema avançado para gerar badges específicos por plataforma

# Função para detectar tipo de plataforma e gerar badges específicos
generate_platform_badges() {
    local provider="$1"
    local course_name="$2"
    local area="$3"
    
    # Converter para lowercase para comparação
    local provider_lower=$(echo "$provider" | tr '[:upper:]' '[:lower:]')
    local course_lower=$(echo "$course_name" | tr '[:upper:]' '[:lower:]')
    
    # Array para armazenar badges
    local badges=()
    
    # Badges baseados na plataforma
    case "$provider_lower" in
        *alura*)
            badges+=("![Alura](https://img.shields.io/badge/Platform-Alura-1976D2?style=flat-square)")
            badges+=("![Brazilian](https://img.shields.io/badge/Origin-Brazilian-00FF7F?style=flat-square&logo=brazil)")
            badges+=("![Tech_Focus](https://img.shields.io/badge/Focus-Technology-blue?style=flat-square&logo=code)")
            badges+=("![Portuguese](https://img.shields.io/badge/Language-Portuguese-green?style=flat-square&logo=language)")
            ;;
        *aws*)
            badges+=("![AWS Training](https://img.shields.io/badge/Platform-AWS_Training-FF9900?style=flat-square&logo=amazon-aws)")
            badges+=("![Cloud](https://img.shields.io/badge/Category-Cloud-orange?style=flat-square&logo=cloud)")
            ;;
        *codecademy*)
            badges+=("![Codecademy](https://img.shields.io/badge/Platform-Codecademy-1F4056?style=flat-square)")
            badges+=("![Interactive](https://img.shields.io/badge/Type-Interactive-success?style=flat-square&logo=play)")
            badges+=("![Learn_by_Doing](https://img.shields.io/badge/Method-Learn_by_Doing-blue?style=flat-square&logo=code)")
            badges+=("![Beginner_Friendly](https://img.shields.io/badge/Level-Beginner_Friendly-green?style=flat-square&logo=seedling)")
            ;;
        *comptia*)
            badges+=("![CompTIA](https://img.shields.io/badge/Platform-CompTIA-CE3B2F?style=flat-square)")
            badges+=("![Certification](https://img.shields.io/badge/Type-Certification-success?style=flat-square&logo=certificate)")
            ;;
        *coursera*)
            badges+=("![Coursera](https://img.shields.io/badge/Platform-Coursera-0056D3?style=flat-square&logo=coursera)")
            badges+=("![Certificate](https://img.shields.io/badge/Certificate-Available-gold?style=flat-square&logo=certificate)")
            ;;
        *dio*)
            badges+=("![DIO](https://img.shields.io/badge/Platform-DIO-E6006F?style=flat-square)")
            badges+=("![Brazilian](https://img.shields.io/badge/Origin-Brazilian-00FF7F?style=flat-square&logo=brazil)")
            badges+=("![Bootcamp](https://img.shields.io/badge/Type-Bootcamp-purple?style=flat-square&logo=rocket)")
            badges+=("![Free](https://img.shields.io/badge/Cost-Free-green?style=flat-square&logo=gift)")
            ;;
        *edx*)
            badges+=("![edX](https://img.shields.io/badge/Platform-edX-02262B?style=flat-square&logo=edx)")
            badges+=("![University](https://img.shields.io/badge/Level-University-purple?style=flat-square&logo=university)")
            ;;
        *freecodecamp*|*fcc*)
            badges+=("![FreeCodeCamp](https://img.shields.io/badge/Platform-FreeCodeCamp-0A0A23?style=flat-square)")
            badges+=("![Free](https://img.shields.io/badge/Cost-Free-green?style=flat-square&logo=gift)")
            badges+=("![Open_Source](https://img.shields.io/badge/Type-Open_Source-success?style=flat-square&logo=open-source-initiative)")
            badges+=("![Project_Based](https://img.shields.io/badge/Method-Project_Based-blue?style=flat-square&logo=folder-open)")
            ;;
        *google*)
            badges+=("![Google Cloud](https://img.shields.io/badge/Platform-Google_Cloud-4285F4?style=flat-square&logo=google-cloud)")
            badges+=("![GCP](https://img.shields.io/badge/Category-GCP-red?style=flat-square&logo=google-cloud)")
            ;;
        *linkedin*)
            badges+=("![LinkedIn Learning](https://img.shields.io/badge/Platform-LinkedIn_Learning-0077B5?style=flat-square&logo=linkedin)")
            badges+=("![Professional](https://img.shields.io/badge/Type-Professional-darkblue?style=flat-square&logo=briefcase)")
            ;;
        *microsoft*|*azure*)
            badges+=("![Microsoft Learn](https://img.shields.io/badge/Platform-Microsoft_Learn-5E5E5E?style=flat-square&logo=microsoft)")
            badges+=("![Azure](https://img.shields.io/badge/Category-Azure-0078D4?style=flat-square&logo=microsoft-azure)")
            ;;
        *netacad*|*networking*academy*)
            badges+=("![NetAcad](https://img.shields.io/badge/Platform-Cisco_NetAcad-1BA0D7?style=flat-square&logo=cisco)")
            badges+=("![Networking](https://img.shields.io/badge/Focus-Networking-blue?style=flat-square&logo=network-wired)")
            badges+=("![Hands_On](https://img.shields.io/badge/Type-Hands_On-success?style=flat-square&logo=tools)")
            badges+=("![Industry](https://img.shields.io/badge/Level-Industry-purple?style=flat-square&logo=building)")
            ;;
        *pluralsight*)
            badges+=("![Pluralsight](https://img.shields.io/badge/Platform-Pluralsight-F15B2A?style=flat-square&logo=pluralsight)")
            badges+=("![Tech](https://img.shields.io/badge/Focus-Technology-blue?style=flat-square&logo=code)")
            ;;
        *rocketseat*)
            badges+=("![Rocketseat](https://img.shields.io/badge/Platform-Rocketseat-8257E5?style=flat-square)")
            badges+=("![Brazilian](https://img.shields.io/badge/Origin-Brazilian-00FF7F?style=flat-square&logo=brazil)")
            badges+=("![Modern_Stack](https://img.shields.io/badge/Focus-Modern_Stack-purple?style=flat-square&logo=rocket)")
            badges+=("![Community](https://img.shields.io/badge/Type-Community-orange?style=flat-square&logo=users)")
            ;;
        *santander*|*santanderopenacademy*)
            badges+=("![Santander Open Academy](https://img.shields.io/badge/Platform-Santander_Open_Academy-EC0000?style=flat-square)")
            badges+=("![Banking](https://img.shields.io/badge/Sector-Banking-red?style=flat-square&logo=university)")
            badges+=("![Free_Access](https://img.shields.io/badge/Cost-Free-green?style=flat-square&logo=gift)")
            badges+=("![Professional](https://img.shields.io/badge/Focus-Professional-blue?style=flat-square&logo=briefcase)")
            ;;
        *udacity*)
            badges+=("![Udacity](https://img.shields.io/badge/Platform-Udacity-02B3E4?style=flat-square)")
            badges+=("![Nanodegree](https://img.shields.io/badge/Type-Nanodegree-gold?style=flat-square&logo=graduation-cap)")
            badges+=("![Industry_Partners](https://img.shields.io/badge/With-Industry_Partners-purple?style=flat-square&logo=handshake)")
            badges+=("![Career_Focused](https://img.shields.io/badge/Focus-Career_Ready-orange?style=flat-square&logo=briefcase)")
            ;;
        *udemy*)
            badges+=("![Udemy](https://img.shields.io/badge/Platform-Udemy-EC5252?style=flat-square&logo=udemy)")
            badges+=("![Online](https://img.shields.io/badge/Mode-Online-green?style=flat-square&logo=wifi)")
            ;;
        *)
            badges+=("![Platform](https://img.shields.io/badge/Platform-${provider}-blue?style=flat-square)")
            ;;
    esac
    
    
    # Adicionar badges avançados de tecnologia
    local tech_badges
    tech_badges=$(detect_advanced_technologies "$course_name $provider")
    if [ -n "$tech_badges" ]; then
        while IFS= read -r badge; do
            badges+=("$badge")
        done <<< "$tech_badges"
    fi
    
    if [[ "$course_lower" == *"linux"* ]]; then
        badges+=("![Linux](https://img.shields.io/badge/OS-Linux-FCC624?style=flat-square&logo=linux)")
    fi
    
    if [[ "$course_lower" == *"security"* ]] || [[ "$course_lower" == *"cyber"* ]]; then
        badges+=("![Security](https://img.shields.io/badge/Focus-Security-red?style=flat-square&logo=shield)")
    fi
    
    # Badges baseados na área
    case "$area" in
        "01_DevOps")
            badges+=("![DevOps](https://img.shields.io/badge/Area-DevOps-FF6B6B?style=flat-square&logo=devopsag)")
            ;;
        "02_Cloud-Computing")
            badges+=("![Cloud](https://img.shields.io/badge/Area-Cloud_Computing-4ECDC4?style=flat-square&logo=cloud)")
            ;;
        "03_Security")
            badges+=("![Security](https://img.shields.io/badge/Area-Security-E74C3C?style=flat-square&logo=shield)")
            ;;
        "04_Linux-Infrastructure")
            badges+=("![Infrastructure](https://img.shields.io/badge/Area-Infrastructure-2ECC71?style=flat-square&logo=server)")
            ;;
        "05_Programming")
            badges+=("![Programming](https://img.shields.io/badge/Area-Programming-9B59B6?style=flat-square&logo=code)")
            ;;
        "06_Data-Science")
            badges+=("![Data Science](https://img.shields.io/badge/Area-Data_Science-F39C12?style=flat-square&logo=databricks)")
            ;;
    esac
    
    # Retornar badges como string
    printf '%s\n' "${badges[@]}"
}

# Função para gerar badges para certificações
generate_certification_badges() {
    local cert_name="$1"
    local provider="$2"
    local area="$3"
    
    local provider_lower=$(echo "$provider" | tr '[:upper:]' '[:lower:]')
    local cert_lower=$(echo "$cert_name" | tr '[:upper:]' '[:lower:]')
    
    local badges=()
    
    # Status sempre presente
    badges+=("![Status](https://img.shields.io/badge/Status-Certified-success?style=flat-square&logo=certificate)")
    
    # Badges específicos por certificadora
    case "$provider_lower" in
        *alura*)
            badges+=("![Alura](https://img.shields.io/badge/Provider-Alura-1976D2?style=flat-square)")
            badges+=("![Brazilian](https://img.shields.io/badge/Origin-Brazilian-00FF7F?style=flat-square&logo=brazil)")
            badges+=("![Portuguese](https://img.shields.io/badge/Language-Portuguese-green?style=flat-square&logo=language)")
            ;;
        *aws*)
            badges+=("![AWS](https://img.shields.io/badge/Provider-AWS-FF9900?style=flat-square&logo=amazon-aws)")
            if [[ "$cert_lower" == *"associate"* ]]; then
                badges+=("![Level](https://img.shields.io/badge/Level-Associate-blue?style=flat-square)")
            elif [[ "$cert_lower" == *"professional"* ]]; then
                badges+=("![Level](https://img.shields.io/badge/Level-Professional-purple?style=flat-square)")
            elif [[ "$cert_lower" == *"specialty"* ]]; then
                badges+=("![Level](https://img.shields.io/badge/Level-Specialty-red?style=flat-square)")
            fi
            ;;
        *cisco*)
            badges+=("![Cisco](https://img.shields.io/badge/Provider-Cisco-1BA0D7?style=flat-square&logo=cisco)")
            ;;
        *codecademy*)
            badges+=("![Codecademy](https://img.shields.io/badge/Provider-Codecademy-1F4056?style=flat-square)")
            badges+=("![Interactive](https://img.shields.io/badge/Type-Interactive-success?style=flat-square&logo=play)")
            ;;
        *comptia*)
            badges+=("![CompTIA](https://img.shields.io/badge/Provider-CompTIA-CE3B2F?style=flat-square)")
            ;;
        *dio*)
            badges+=("![DIO](https://img.shields.io/badge/Provider-DIO-E6006F?style=flat-square)")
            badges+=("![Brazilian](https://img.shields.io/badge/Origin-Brazilian-00FF7F?style=flat-square&logo=brazil)")
            ;;
        *freecodecamp*|*fcc*)
            badges+=("![FreeCodeCamp](https://img.shields.io/badge/Provider-FreeCodeCamp-0A0A23?style=flat-square)")
            badges+=("![Free](https://img.shields.io/badge/Cost-Free-green?style=flat-square&logo=gift)")
            badges+=("![Open_Source](https://img.shields.io/badge/Type-Open_Source-success?style=flat-square&logo=open-source-initiative)")
            ;;
        *google*|*gcp*)
            badges+=("![Google Cloud](https://img.shields.io/badge/Provider-Google_Cloud-4285F4?style=flat-square&logo=google-cloud)")
            ;;
        *microsoft*|*azure*)
            badges+=("![Microsoft](https://img.shields.io/badge/Provider-Microsoft-5E5E5E?style=flat-square&logo=microsoft)")
            badges+=("![Azure](https://img.shields.io/badge/Platform-Azure-0078D4?style=flat-square&logo=microsoft-azure)")
            ;;
        *netacad*|*networking*academy*)
            badges+=("![NetAcad](https://img.shields.io/badge/Provider-Cisco_NetAcad-1BA0D7?style=flat-square&logo=cisco)")
            badges+=("![Industry](https://img.shields.io/badge/Level-Industry-purple?style=flat-square&logo=building)")
            ;;
        *redhat*)
            badges+=("![Red Hat](https://img.shields.io/badge/Provider-Red_Hat-EE0000?style=flat-square&logo=redhat)")
            ;;
        *rocketseat*)
            badges+=("![Rocketseat](https://img.shields.io/badge/Provider-Rocketseat-8257E5?style=flat-square)")
            badges+=("![Brazilian](https://img.shields.io/badge/Origin-Brazilian-00FF7F?style=flat-square&logo=brazil)")
            badges+=("![Modern_Stack](https://img.shields.io/badge/Focus-Modern_Stack-purple?style=flat-square&logo=rocket)")
            ;;
        *santander*|*santanderopenacademy*)
            badges+=("![Santander Open Academy](https://img.shields.io/badge/Provider-Santander_Open_Academy-EC0000?style=flat-square)")
            badges+=("![Banking](https://img.shields.io/badge/Sector-Banking-red?style=flat-square&logo=university)")
            badges+=("![Professional](https://img.shields.io/badge/Focus-Professional-blue?style=flat-square&logo=briefcase)")
            ;;
        *udacity*)
            badges+=("![Udacity](https://img.shields.io/badge/Provider-Udacity-02B3E4?style=flat-square)")
            badges+=("![Nanodegree](https://img.shields.io/badge/Type-Nanodegree-gold?style=flat-square&logo=graduation-cap)")
            badges+=("![Industry_Partners](https://img.shields.io/badge/With-Industry_Partners-purple?style=flat-square&logo=handshake)")
            ;;
        *)
            badges+=("![Provider](https://img.shields.io/badge/Provider-${provider}-blue?style=flat-square)")
            ;;
    esac
    
    # Adicionar badges avançados de tecnologia
    local tech_badges
    tech_badges=$(detect_advanced_technologies "$cert_name $provider")
    if [ -n "$tech_badges" ]; then
        while IFS= read -r badge; do
            badges+=("$badge")
        done <<< "$tech_badges"
    fi
    
    # Adicionar data será feita no script principal
    badges+=("![Date](https://img.shields.io/badge/Date-[DD%2FMM%2FAAAA]-lightgrey?style=flat-square&logo=calendar)")
    
    printf '%s\n' "${badges[@]}"
}

# Função principal para integrar com o portfolio manager
enhance_course_template() {
    local course_file="$1"
    local provider="$2"
    local course_name="$3"
    local area="$4"
    
    # Gerar badges personalizados
    local badges=$(generate_platform_badges "$provider" "$course_name" "$area")
    
    # Adicionar badges no início do arquivo (após o título)
    local temp_file=$(mktemp)
    
    # Ler primeira linha (título)
    head -n 1 "$course_file" > "$temp_file"
    echo >> "$temp_file"
    
    # Adicionar badges personalizados
    echo "$badges" >> "$temp_file"
    echo >> "$temp_file"
    
    # Adicionar resto do arquivo
    tail -n +2 "$course_file" >> "$temp_file"
    
    # Substituir arquivo original
    mv "$temp_file" "$course_file"
}

# Função para certificações
enhance_certification_template() {
    local cert_file="$1"
    local provider="$2"
    local cert_name="$3"
    local area="$4"
    local cert_date="$5"
    
    # Gerar badges personalizados
    local badges=$(generate_certification_badges "$cert_name" "$provider" "$area")
    
    # Substituir placeholder de data
    badges=$(echo "$badges" | sed "s/\[DD%2FMM%2FAAAA\]/${cert_date//\//%2F}/g")
    
    # Adicionar badges no arquivo
    local temp_file=$(mktemp)
    
    # Ler primeira linha (título)
    head -n 1 "$cert_file" > "$temp_file"
    echo >> "$temp_file"
    
    # Adicionar badges personalizados
    echo "$badges" >> "$temp_file"
    echo >> "$temp_file"
    
    # Adicionar resto do arquivo
    tail -n +2 "$cert_file" >> "$temp_file"
    
    # Substituir arquivo original
    mv "$temp_file" "$cert_file"
}

# Função avançada para detectar tecnologias e frameworks
detect_advanced_technologies() {
    local content="$1"
    local content_lower=$(echo "$content" | tr '[:upper:]' '[:lower:]')
    local tech_badges=()
    
    # Machine Learning / AI
    if [[ "$content_lower" == *"tensorflow"* ]]; then
        tech_badges+=("![TensorFlow](https://img.shields.io/badge/TensorFlow-FF6F00?style=flat-square&logo=tensorflow&logoColor=white)")
    fi
    if [[ "$content_lower" == *"pytorch"* ]]; then
        tech_badges+=("![PyTorch](https://img.shields.io/badge/PyTorch-EE4C2C?style=flat-square&logo=pytorch&logoColor=white)")
    fi
    if [[ "$content_lower" == *"scikit-learn"* ]] || [[ "$content_lower" == *"sklearn"* ]]; then
        tech_badges+=("![Scikit Learn](https://img.shields.io/badge/scikit--learn-F7931E?style=flat-square&logo=scikit-learn&logoColor=white)")
    fi
    if [[ "$content_lower" == *"keras"* ]]; then
        tech_badges+=("![Keras](https://img.shields.io/badge/Keras-D00000?style=flat-square&logo=keras&logoColor=white)")
    fi
    if [[ "$content_lower" == *"pandas"* ]]; then
        tech_badges+=("![Pandas](https://img.shields.io/badge/pandas-150458?style=flat-square&logo=pandas&logoColor=white)")
    fi
    if [[ "$content_lower" == *"numpy"* ]]; then
        tech_badges+=("![NumPy](https://img.shields.io/badge/numpy-013243?style=flat-square&logo=numpy&logoColor=white)")
    fi
    if [[ "$content_lower" == *"jupyter"* ]]; then
        tech_badges+=("![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=flat-square&logo=jupyter&logoColor=white)")
    fi
    
    # Cloud Platforms
    if [[ "$content_lower" == *"aws"* ]] || [[ "$content_lower" == *"amazon web services"* ]]; then
        tech_badges+=("![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat-square&logo=amazon-aws&logoColor=white)")
    fi
    if [[ "$content_lower" == *"azure"* ]]; then
        tech_badges+=("![Azure](https://img.shields.io/badge/Microsoft%20Azure-0078D4?style=flat-square&logo=microsoft-azure&logoColor=white)")
    fi
    if [[ "$content_lower" == *"google cloud"* ]] || [[ "$content_lower" == *"gcp"* ]]; then
        tech_badges+=("![Google Cloud](https://img.shields.io/badge/Google%20Cloud-4285F4?style=flat-square&logo=google-cloud&logoColor=white)")
    fi
    if [[ "$content_lower" == *"digitalocean"* ]]; then
        tech_badges+=("![DigitalOcean](https://img.shields.io/badge/DigitalOcean-0080FF?style=flat-square&logo=digitalocean&logoColor=white)")
    fi
    
    # Programming Languages
    if [[ "$content_lower" == *"python"* ]]; then
        tech_badges+=("![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)")
    fi
    if [[ "$content_lower" == *"javascript"* ]] || [[ "$content_lower" == *"js"* ]]; then
        tech_badges+=("![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black)")
    fi
    if [[ "$content_lower" == *"typescript"* ]]; then
        tech_badges+=("![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white)")
    fi
    if [[ "$content_lower" == *"java"* ]] && [[ "$content_lower" != *"javascript"* ]]; then
        tech_badges+=("![Java](https://img.shields.io/badge/Java-ED8B00?style=flat-square&logo=java&logoColor=white)")
    fi
    if [[ "$content_lower" == *"golang"* ]] || [[ "$content_lower" == *"go"* ]]; then
        tech_badges+=("![Go](https://img.shields.io/badge/Go-00ADD8?style=flat-square&logo=go&logoColor=white)")
    fi
    if [[ "$content_lower" == *"rust"* ]]; then
        tech_badges+=("![Rust](https://img.shields.io/badge/Rust-000000?style=flat-square&logo=rust&logoColor=white)")
    fi
    
    # Web Frameworks
    if [[ "$content_lower" == *"react"* ]]; then
        tech_badges+=("![React](https://img.shields.io/badge/React-20232A?style=flat-square&logo=react&logoColor=61DAFB)")
    fi
    if [[ "$content_lower" == *"vue"* ]]; then
        tech_badges+=("![Vue.js](https://img.shields.io/badge/Vue.js-35495E?style=flat-square&logo=vue.js&logoColor=4FC08D)")
    fi
    if [[ "$content_lower" == *"angular"* ]]; then
        tech_badges+=("![Angular](https://img.shields.io/badge/Angular-DD0031?style=flat-square&logo=angular&logoColor=white)")
    fi
    if [[ "$content_lower" == *"next.js"* ]] || [[ "$content_lower" == *"nextjs"* ]]; then
        tech_badges+=("![Next.js](https://img.shields.io/badge/Next.js-000000?style=flat-square&logo=next.js&logoColor=white)")
    fi
    if [[ "$content_lower" == *"svelte"* ]]; then
        tech_badges+=("![Svelte](https://img.shields.io/badge/Svelte-4A4A55?style=flat-square&logo=svelte&logoColor=FF3E00)")
    fi
    
    # Backend Frameworks
    if [[ "$content_lower" == *"node.js"* ]] || [[ "$content_lower" == *"nodejs"* ]]; then
        tech_badges+=("![Node.js](https://img.shields.io/badge/Node.js-43853D?style=flat-square&logo=node.js&logoColor=white)")
    fi
    if [[ "$content_lower" == *"express"* ]]; then
        tech_badges+=("![Express.js](https://img.shields.io/badge/Express.js-404D59?style=flat-square)")
    fi
    if [[ "$content_lower" == *"django"* ]]; then
        tech_badges+=("![Django](https://img.shields.io/badge/Django-092E20?style=flat-square&logo=django&logoColor=white)")
    fi
    if [[ "$content_lower" == *"flask"* ]]; then
        tech_badges+=("![Flask](https://img.shields.io/badge/Flask-000000?style=flat-square&logo=flask&logoColor=white)")
    fi
    if [[ "$content_lower" == *"fastapi"* ]]; then
        tech_badges+=("![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=flat-square&logo=fastapi)")
    fi
    
    # Databases
    if [[ "$content_lower" == *"mysql"* ]]; then
        tech_badges+=("![MySQL](https://img.shields.io/badge/MySQL-00000F?style=flat-square&logo=mysql&logoColor=white)")
    fi
    if [[ "$content_lower" == *"postgresql"* ]] || [[ "$content_lower" == *"postgres"* ]]; then
        tech_badges+=("![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=flat-square&logo=postgresql&logoColor=white)")
    fi
    if [[ "$content_lower" == *"mongodb"* ]]; then
        tech_badges+=("![MongoDB](https://img.shields.io/badge/MongoDB-4EA94B?style=flat-square&logo=mongodb&logoColor=white)")
    fi
    if [[ "$content_lower" == *"redis"* ]]; then
        tech_badges+=("![Redis](https://img.shields.io/badge/redis-CC0000.svg?&style=flat-square&logo=redis&logoColor=white)")
    fi
    if [[ "$content_lower" == *"sqlite"* ]]; then
        tech_badges+=("![SQLite](https://img.shields.io/badge/SQLite-07405E?style=flat-square&logo=sqlite&logoColor=white)")
    fi
    
    # DevOps & Tools
    if [[ "$content_lower" == *"docker"* ]]; then
        tech_badges+=("![Docker](https://img.shields.io/badge/docker-0db7ed.svg?&style=flat-square&logo=docker&logoColor=white)")
    fi
    if [[ "$content_lower" == *"kubernetes"* ]] || [[ "$content_lower" == *"k8s"* ]]; then
        tech_badges+=("![Kubernetes](https://img.shields.io/badge/kubernetes-326ce5.svg?&style=flat-square&logo=kubernetes&logoColor=white)")
    fi
    if [[ "$content_lower" == *"terraform"* ]]; then
        tech_badges+=("![Terraform](https://img.shields.io/badge/terraform-5835CC.svg?&style=flat-square&logo=terraform&logoColor=white)")
    fi
    if [[ "$content_lower" == *"ansible"* ]]; then
        tech_badges+=("![Ansible](https://img.shields.io/badge/ansible-1A1918.svg?&style=flat-square&logo=ansible&logoColor=white)")
    fi
    if [[ "$content_lower" == *"jenkins"* ]]; then
        tech_badges+=("![Jenkins](https://img.shields.io/badge/jenkins-D24939.svg?&style=flat-square&logo=jenkins&logoColor=white)")
    fi
    if [[ "$content_lower" == *"gitlab"* ]]; then
        tech_badges+=("![GitLab](https://img.shields.io/badge/GitLab-330F63?style=flat-square&logo=gitlab&logoColor=white)")
    fi
    if [[ "$content_lower" == *"github actions"* ]]; then
        tech_badges+=("![GitHub Actions](https://img.shields.io/badge/github%20actions-2671E5.svg?&style=flat-square&logo=githubactions&logoColor=white)")
    fi
    
    # Web Technologies
    if [[ "$content_lower" == *"html"* ]]; then
        tech_badges+=("![HTML5](https://img.shields.io/badge/html5-E34F26.svg?&style=flat-square&logo=html5&logoColor=white)")
    fi
    if [[ "$content_lower" == *"css"* ]]; then
        tech_badges+=("![CSS3](https://img.shields.io/badge/css3-1572B6.svg?&style=flat-square&logo=css3&logoColor=white)")
    fi
    if [[ "$content_lower" == *"sass"* ]] || [[ "$content_lower" == *"scss"* ]]; then
        tech_badges+=("![SASS](https://img.shields.io/badge/SASS-hotpink.svg?&style=flat-square&logo=SASS&logoColor=white)")
    fi
    if [[ "$content_lower" == *"tailwind"* ]]; then
        tech_badges+=("![TailwindCSS](https://img.shields.io/badge/tailwindcss-38B2AC.svg?&style=flat-square&logo=tailwind-css&logoColor=white)")
    fi
    
    # Testing & Quality
    if [[ "$content_lower" == *"jest"* ]]; then
        tech_badges+=("![Jest](https://img.shields.io/badge/-jest-C21325?&style=flat-square&logo=jest&logoColor=white)")
    fi
    if [[ "$content_lower" == *"cypress"* ]]; then
        tech_badges+=("![Cypress](https://img.shields.io/badge/-cypress-17202C?&style=flat-square&logo=cypress&logoColor=white)")
    fi
    if [[ "$content_lower" == *"selenium"* ]]; then
        tech_badges+=("![Selenium](https://img.shields.io/badge/-selenium-43B02A?&style=flat-square&logo=selenium&logoColor=white)")
    fi
    
    # Mobile Development
    if [[ "$content_lower" == *"react native"* ]]; then
        tech_badges+=("![React Native](https://img.shields.io/badge/React_Native-20232A?style=flat-square&logo=react&logoColor=61DAFB)")
    fi
    if [[ "$content_lower" == *"flutter"* ]]; then
        tech_badges+=("![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)")
    fi
    if [[ "$content_lower" == *"ionic"* ]]; then
        tech_badges+=("![Ionic](https://img.shields.io/badge/Ionic-3880FF?style=flat-square&logo=ionic&logoColor=white)")
    fi
    
    # Server & Infrastructure
    if [[ "$content_lower" == *"nginx"* ]]; then
        tech_badges+=("![Nginx](https://img.shields.io/badge/nginx-009639.svg?&style=flat-square&logo=nginx&logoColor=white)")
    fi
    if [[ "$content_lower" == *"apache"* ]]; then
        tech_badges+=("![Apache](https://img.shields.io/badge/apache-D42029.svg?&style=flat-square&logo=apache&logoColor=white)")
    fi
    if [[ "$content_lower" == *"linux"* ]]; then
        tech_badges+=("![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)")
    fi
    if [[ "$content_lower" == *"ubuntu"* ]]; then
        tech_badges+=("![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=flat-square&logo=ubuntu&logoColor=white)")
    fi
    
    # Data & Analytics
    if [[ "$content_lower" == *"elasticsearch"* ]]; then
        tech_badges+=("![Elasticsearch](https://img.shields.io/badge/-ElasticSearch-005571?&style=flat-square&logo=elasticsearch)")
    fi
    if [[ "$content_lower" == *"kibana"* ]]; then
        tech_badges+=("![Kibana](https://img.shields.io/badge/-kibana-005571?&style=flat-square&logo=kibana)")
    fi
    if [[ "$content_lower" == *"grafana"* ]]; then
        tech_badges+=("![Grafana](https://img.shields.io/badge/-grafana-F46800?&style=flat-square&logo=grafana&logoColor=white)")
    fi
    if [[ "$content_lower" == *"prometheus"* ]]; then
        tech_badges+=("![Prometheus](https://img.shields.io/badge/-prometheus-E6522C?&style=flat-square&logo=prometheus&logoColor=white)")
    fi
    
    # Retornar badges como string
    printf '%s\n' "${tech_badges[@]}"
}

# Aliases para compatibilidade com validador
detect_technologies() {
    detect_advanced_technologies "$@"
}

generate_technology_badges() {
    detect_advanced_technologies "$@"
}
