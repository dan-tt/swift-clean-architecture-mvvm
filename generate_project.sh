#!/bin/bash

# generate_project.sh
# Regenerates Xcode project using xcodegen based on current file structure

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="MySwiftUIApp"
PROJECT_YML="project.yml"
XCODEPROJ_PATH="$PROJECT_NAME.xcodeproj"

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if xcodegen is installed
check_xcodegen() {
    if ! command -v xcodegen &> /dev/null; then
        print_error "xcodegen is not installed"
        print_info "Install with: brew install xcodegen"
        print_info "Or visit: https://github.com/yonaskolb/XcodeGen"
        exit 1
    fi
    
    local version=$(xcodegen --version)
    print_success "xcodegen found: $version"
}

# Scan project structure and display summary
scan_project_structure() {
    print_info "Scanning project structure..."
    
    # Count files by type
    local swift_files=$(find MySwiftUIApp -name "*.swift" -not -path "*/.*" | wc -l | tr -d ' ')
    local xcassets=$(find MySwiftUIApp -name "*.xcassets" -not -path "*/.*" | wc -l | tr -d ' ')
    local plists=$(find MySwiftUIApp -name "*.plist" -not -path "*/.*" | wc -l | tr -d ' ')
    local json_files=$(find MySwiftUIApp -name "*.json" -not -path "*/.*" | wc -l | tr -d ' ')
    
    echo ""
    echo "📊 Project Structure Summary:"
    echo "================================"
    echo "📁 Swift files: $swift_files"
    echo "📦 Asset catalogs: $xcassets"
    echo "📄 Plist files: $plists"
    echo "📋 JSON files: $json_files"
    echo ""
    
    # Display directory structure
    echo "📂 Directory Structure:"
    echo "----------------------"
    if command -v tree &> /dev/null; then
        tree MySwiftUIApp -I ".*|Build|DerivedData|*.md" --dirsfirst -L 3
    else
        find MySwiftUIApp -type d -not -path "*/.*" | head -20 | sort
    fi
    echo ""
}

# Generate project using xcodegen
generate_project() {
    print_info "Generating Xcode project with xcodegen..."
    
    # Run xcodegen
    if xcodegen generate --spec "$PROJECT_YML" --use-cache; then
        print_success "Xcode project generated successfully!"
    else
        print_error "Failed to generate Xcode project"
        exit 1
    fi
}

# Validate generated project
validate_project() {
    print_info "Validating generated project..."
    
    # Check if project was created
    if [ ! -d "$XCODEPROJ_PATH" ]; then
        print_error "Project was not created"
        exit 1
    fi
    
    # Check if project can be opened (basic validation)
    if xcodebuild -project "$XCODEPROJ_PATH" -list &> /dev/null; then
        print_success "Project validation passed"
    else
        print_warning "Project validation failed, but project was created"
    fi
}

# Optional: Build project to ensure it compiles
build_project() {
    if [ "$1" = "--build" ]; then
        print_info "Building project to verify compilation..."
        
        if xcodebuild -project "$XCODEPROJ_PATH" -scheme "$PROJECT_NAME" -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' build &> /dev/null; then
            print_success "Project builds successfully!"
        else
            print_warning "Project has build issues (this is normal if dependencies are missing)"
        fi
    fi
}

# Main execution
main() {
    echo "🔄 Xcode Project Regeneration"
    echo "============================="
    echo ""
    
    # Check if we're in the right directory
    if [ ! -f "$PROJECT_YML" ]; then
        print_error "project.yml not found. Please run this script from the project root."
        exit 1
    fi
    
    # Check requirements
    check_xcodegen
    
    # Scan and display structure
    scan_project_structure
    
    # Ask for confirmation unless --force is used
    if [ "$1" != "--force" ] && [ "$1" != "--build" ]; then
        echo "⚠️ This will regenerate the entire Xcode project."
        echo "💡 All manual changes to project settings will be lost."
        echo "📄 Project structure will be based on project.yml"
        echo ""
        read -p "Proceed with regeneration? (y/N): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_info "Regeneration cancelled."
            exit 0
        fi
    fi
    
    # Generate project
    generate_project
    
    # Validate project
    validate_project
    
    # Optional build
    build_project "$1"
    
    echo ""
    print_success "Xcode project regeneration complete! 🎉"
    print_info "Open $XCODEPROJ_PATH to see the updated project"
    
    # Display helpful tips
    echo ""
    echo "💡 Tips:"
    echo "- The project structure now matches your file system"
    echo "- All files are automatically included based on file extensions"
    echo "- Run this script anytime you add/remove files"
    echo "- Use --force to skip confirmation prompt"
    echo "- Use --build to verify the project compiles"
    echo ""
}

# Handle script arguments
case "$1" in
    --help|-h)
        echo "Usage: $0 [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  --force    Skip confirmation prompt"
        echo "  --build    Build project after generation to verify compilation"
        echo "  --help     Show this help message"
        echo ""
        echo "This script uses xcodegen to regenerate the Xcode project"
        echo "based on the current file structure and project.yml configuration."
        exit 0
        ;;
    *)
        main "$1"
        ;;
esac
