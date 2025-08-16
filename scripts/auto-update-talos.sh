#!/bin/bash
set -euo pipefail

# Talos Auto-Apply Script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TALOS_DIR="$SCRIPT_DIR/../kubernetes/talos"
CLUSTER_NAME="optiplex-k8s"

# Node configuration
declare -A NODES=(
    ["talos-1.mafyuh.com"]="10.0.0.9"
    ["talos-2.mafyuh.com"]="10.0.0.84"
    ["talos-3.mafyuh.com"]="10.0.0.177"
)

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "${BLUE}[$(date +'%H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Check if talhelper is available
check_talhelper() {
    if ! command -v talhelper &> /dev/null; then
        error "talhelper is not installed"
        exit 1
    fi
}

# Check if talosctl is available
check_talosctl() {
    if ! command -v talosctl &> /dev/null; then
        error "talosctl is not installed"
        exit 1
    fi
}

# Regenerate configs with talhelper
generate_configs() {
    log "Regenerating Talos configurations with talhelper..."
    
    cd "$TALOS_DIR"
    if talhelper genconfig; then
        success "Configurations regenerated successfully"
        return 0
    else
        error "Failed to regenerate configurations"
        return 1
    fi
}

# Apply configs to all nodes
apply_configs() {
    log "Applying configurations to all nodes..."
    
    # Set the talosconfig and endpoints
    local talosconfig="$TALOS_DIR/clusterconfig/talosconfig"
    local endpoints="10.0.0.9,10.0.0.84,10.0.0.177"
    
    if [ ! -f "$talosconfig" ]; then
        error "Talosconfig not found: $talosconfig"
        return 1
    fi
    
    for hostname in "${!NODES[@]}"; do
        local ip="${NODES[$hostname]}"
        local config_file="$TALOS_DIR/clusterconfig/$CLUSTER_NAME-$hostname.yaml"
        
        log "Applying config to $hostname ($ip)..."
        
        if [ ! -f "$config_file" ]; then
            error "Config file not found: $config_file"
            return 1
        fi
        
        if talosctl --talosconfig "$talosconfig" \
            --endpoints "$endpoints" \
            apply-config \
            --nodes "$ip" \
            --file "$config_file"; then
            success "Configuration applied to $hostname"
        else
            error "Failed to apply configuration to $hostname"
            return 1
        fi
    done
    
    success "All configurations applied successfully"
}

# Main function
main() {
    log "Starting Talos auto-update process..."
    
    check_talhelper
    check_talosctl
    
    if generate_configs && apply_configs; then
        success "Talos auto-update completed successfully!"
    else
        error "Talos auto-update failed!"
        exit 1
    fi
}

main "$@"
