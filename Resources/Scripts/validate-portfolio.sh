#!/bin/bash

# ========================================
# Learning Portfolio Validator
# ========================================
# Validates the integrity and consistency of the Learning Portfolio structure
# 
# Features:
# - Directory structure validation
# - File consistency checking
# - README format validation
# - Badge generation validation
# - Script syntax checking
# - Statistical consistency validation
#
# Author: Learning Journey Portfolio System
# Version: 1.0
# ========================================

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters for validation results
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0
WARNING_CHECKS=0

# Print colored message
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Print section header
print_section() {
    local title=$1
    echo
    print_message "$BLUE" "========================================="
    print_message "$BLUE" "$title"
    print_message "$BLUE" "========================================="
}

# Increment counters
increment_check() {
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    case $1 in
        "PASS") PASSED_CHECKS=$((PASSED_CHECKS + 1)) ;;
        "FAIL") FAILED_CHECKS=$((FAILED_CHECKS + 1)) ;;
        "WARN") WARNING_CHECKS=$((WARNING_CHECKS + 1)) ;;
    esac
}

# Validate result
validate_check() {
    local description=$1
    local condition=$2
    local severity=${3:-"FAIL"}
    
    if [ "$condition" = "true" ]; then
        print_message "$GREEN" "✓ $description"
        increment_check "PASS"
    else
        if [ "$severity" = "WARN" ]; then
            print_message "$YELLOW" "⚠ $description"
            increment_check "WARN"
        else
            print_message "$RED" "✗ $description"
            increment_check "FAIL"
        fi
    fi
}

# Check if directory exists
check_directory() {
    local dir=$1
    local desc=$2
    validate_check "$desc" "$([ -d "$dir" ] && echo true || echo false)"
}

# Check if file exists
check_file() {
    local file=$1
    local desc=$2
    validate_check "$desc" "$([ -f "$file" ] && echo true || echo false)"
}

# Validate directory structure
validate_structure() {
    print_section "VALIDATING DIRECTORY STRUCTURE"
    local repo_root
    repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
    
    # Check main directories
    check_directory "$repo_root/Learning-Journey" "Main Learning-Journey directory exists"
    check_directory "$repo_root/Resources" "Resources directory exists"
    check_directory "$repo_root/Resources/Scripts" "Scripts directory exists"
    check_directory "$repo_root/Resources/Templates" "Templates directory exists"
    
    # Check Learning-Journey subdirectories
    local area_dirs=("01_DevOps" "02_Cloud-Computing" "03_Security" "04_Linux-Infrastructure" "05_Programming" "06_Data-Science")
    for area in "${area_dirs[@]}"; do
        check_directory "$repo_root/Learning-Journey/$area" "Directory Learning-Journey/$area exists"
    done
    
    # Check for README files
    check_file "$repo_root/README.md" "Root README.md exists"
    check_file "$repo_root/README_pt-br.md" "Root README_pt-br.md exists"
}

# Validate script files
validate_scripts() {
    print_section "VALIDATING SCRIPT FILES"
    
    local scripts=("portfolio-manager.sh" "enhanced-badge-generator.sh" "update-stats.sh" "update-current-courses.sh")
    
    for script in "${scripts[@]}"; do
        local script_path="Resources/Scripts/$script"
        check_file "$script_path" "Script $script exists"
        
        if [ -f "$script_path" ]; then
            # Check if script is executable
            validate_check "Script $script is executable" "$([ -x "$script_path" ] && echo true || echo false)" "WARN"
            
            # Basic syntax check
            if bash -n "$script_path" 2>/dev/null; then
                validate_check "Script $script syntax is valid" "true"
            else
                validate_check "Script $script syntax is valid" "false"
            fi
        fi
    done
}

# Validate template files
validate_templates() {
    print_section "VALIDATING TEMPLATE FILES"
    
    local templates=("course-template.md" "certification-template.md" "project-template.md")
    
    for template in "${templates[@]}"; do
        local template_path="Resources/Templates/$template"
        check_file "$template_path" "Template $template exists"
        
        if [ -f "$template_path" ]; then
            # Check if template has required sections
            local required_sections=("# " "## " "### ")
            local has_structure=false
            
            for section in "${required_sections[@]}"; do
                if grep -q "^$section" "$template_path"; then
                    has_structure=true
                    break
                fi
            done
            
            validate_check "Template $template has proper markdown structure" "$has_structure"
        fi
    done
}

# Validate README consistency
validate_readme_consistency() {
    print_section "VALIDATING README CONSISTENCY"
    
    # Check if root README files exist and have content
    if [ -f "README.md" ] && [ -f "README_pt-br.md" ]; then
        local en_size
        local pt_size
        en_size=$(wc -l < "README.md")
        pt_size=$(wc -l < "README_pt-br.md")
        
        validate_check "Root README files have reasonable content (>10 lines)" "$([ "$en_size" -gt 10 ] && [ "$pt_size" -gt 10 ] && echo true || echo false)" "WARN"
        
        # Check for learning journey structure mentions
        if grep -qi "learning.*journey\|portfolio\|curso\|certificat" "README.md"; then
            validate_check "English README mentions learning/portfolio content" "true"
        else
            validate_check "English README mentions learning/portfolio content" "false" "WARN"
        fi
        
        if grep -qi "aprendizado\|jornada\|portfolio\|curso\|certificat" "README_pt-br.md"; then
            validate_check "Portuguese README mentions learning/portfolio content" "true"
        else
            validate_check "Portuguese README mentions learning/portfolio content" "false" "WARN"
        fi
    fi
}

# Validate badge system
validate_badge_system() {
    print_section "VALIDATING BADGE SYSTEM"
    
    # Check if badge generator exists and has key functions
    local badge_script="Resources/Scripts/enhanced-badge-generator.sh"
    if [ -f "$badge_script" ]; then
        # Check for key functions
        local functions=("generate_platform_badges" "generate_technology_badges" "detect_technologies")
        
        for func in "${functions[@]}"; do
            if grep -q "^$func()" "$badge_script"; then
                validate_check "Badge generator has $func function" "true"
            else
                validate_check "Badge generator has $func function" "false" "WARN"
            fi
        done
        
        # Check for platform support
        local platforms=("udemy" "coursera" "edx" "pluralsight")
        local platform_count=0
        
        for platform in "${platforms[@]}"; do
            if grep -qi "$platform" "$badge_script"; then
                platform_count=$((platform_count + 1))
            fi
        done
        
        validate_check "Badge generator supports multiple platforms (>2)" "$([ $platform_count -gt 2 ] && echo true || echo false)"
    fi
}

# Validate file patterns
validate_file_patterns() {
    print_section "VALIDATING FILE PATTERNS"
    
    # Check for portfolio entry files
    local markdown_count
    markdown_count=$(find Learning-Journey -name "*.md" -not -name "README*.md" -type f | wc -l)
    validate_check "Portfolio contains markdown entry files" "$([ "$markdown_count" -gt 0 ] && echo true || echo false)" "WARN"
    
    # Check for consistent naming in entry files (YYYY-MM-DD_provider_name.md)
    local malformed_files
    # Finds files that do NOT match the expected naming convention
    malformed_files=$(find Learning-Journey -name "*.md" -not -name "README*.md" -type f -not -regex '.*/[0-9]{2}/[0-9]{2}/[0-9]{4}_.*\.md' | wc -l)
    validate_check "All entry files follow the DD-MM-YYYY_... naming convention" "$([ "$malformed_files" -eq 0 ] && echo true || echo false)" "WARN"
}

# Generate final report
generate_report() {
    print_section "VALIDATION SUMMARY"
    
    local success_rate=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))
    
    print_message "$BLUE" "Total Checks: $TOTAL_CHECKS"
    print_message "$GREEN" "Passed: $PASSED_CHECKS"
    print_message "$RED" "Failed: $FAILED_CHECKS"
    print_message "$YELLOW" "Warnings: $WARNING_CHECKS"
    print_message "$BLUE" "Success Rate: ${success_rate}%"
    
    echo
    
    if [ "$FAILED_CHECKS" -eq 0 ]; then
        print_message "$GREEN" "🎉 VALIDATION COMPLETED SUCCESSFULLY!"
        print_message "$GREEN" "Your Learning Portfolio is well-structured and consistent."
        if [ "$WARNING_CHECKS" -gt 0 ]; then
            print_message "$YELLOW" "Note: There are $WARNING_CHECKS warnings that you may want to address."
        fi
        return 0
    else
        print_message "$RED" "❌ VALIDATION FAILED!"
        print_message "$RED" "There are $FAILED_CHECKS critical issues that need to be addressed."
        print_message "$YELLOW" "Please fix the failed checks and run validation again."
        return 1
    fi
}

# Main execution
main() {
    print_message "$BLUE" "Starting Learning Portfolio Validation..."
    print_message "$BLUE" "Working Directory: $(pwd)"
    echo
    
    validate_structure
    validate_scripts
    validate_templates
    validate_readme_consistency
    validate_badge_system
    validate_file_patterns
    
    generate_report
}

# Check if script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
