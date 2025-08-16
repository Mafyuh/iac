#!/bin/bash
set -euo pipefail

# Talos Auto-Update Script
# This script regenerates configs with talhelper and applies them to nodes
# If Talos version changed, it performs an upgrade instead of just applying config

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TALOS_DIR="$SCRIPT_DIR/../kubernetes/talos"
CLUSTER_NAME="optiplex-k8s"

# Node configuration - ordered for sequential upgrades
NODES=(
    "talos-1.mafyuh.com:10.0.0.9"
    "talos-2.mafyuh.com:10.0.0.84" 
    "talos-3.mafyuh.com:10.0.0.177"
)

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "${BLUE}[$(date +'%H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
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

# Get current Talos version from cluster
get_current_talos_version() {
    local talosconfig="$TALOS_DIR/clusterconfig/talosconfig"
    local endpoints="10.0.0.9,10.0.0.84,10.0.0.177"
    
    if [ ! -f "$talosconfig" ]; then
        error "Talosconfig not found: $talosconfig"
        return 1
    fi
    
    # Get version from first node
    talosctl --talosconfig "$talosconfig" --endpoints "$endpoints" version --short --client=false | head -1 | awk '{print $2}' || echo "unknown"
}

# Get desired Talos version from talconfig.yaml
get_desired_talos_version() {
    grep "talosVersion:" "$TALOS_DIR/talconfig.yaml" | awk '{print $2}' | tr -d 'v'
}

# Get desired Kubernetes version from talconfig.yaml
get_desired_kubernetes_version() {
    grep "kubernetesVersion:" "$TALOS_DIR/talconfig.yaml" | awk '{print $2}' | tr -d 'v'
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

# Apply configs to all nodes (for non-version changes)
apply_configs() {
    log "Applying configurations to all nodes..."
    
    local talosconfig="$TALOS_DIR/clusterconfig/talosconfig"
    local endpoints="10.0.0.9,10.0.0.84,10.0.0.177"
    
    if [ ! -f "$talosconfig" ]; then
        error "Talosconfig not found: $talosconfig"
        return 1
    fi
    
    for node_info in "${NODES[@]}"; do
        local hostname="${node_info%%:*}"
        local ip="${node_info##*:}"
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

# Get installer image from generated config
get_installer_image() {
    local config_file="$TALOS_DIR/clusterconfig/$CLUSTER_NAME-talos-1.mafyuh.com.yaml"
    
    if [ ! -f "$config_file" ]; then
        error "Config file not found: $config_file"
        return 1
    fi
    
    # Extract the installer image from the generated config
    grep -A 15 "install:" "$config_file" | grep "image:" | awk '{print $2}'
}

# Upgrade Talos version on all nodes sequentially
upgrade_talos() {
    local desired_version="$1"
    local talosconfig="$TALOS_DIR/clusterconfig/talosconfig"
    local endpoints="10.0.0.9,10.0.0.84,10.0.0.177"
    
    # Get the installer image from generated config
    local installer_image
    installer_image=$(get_installer_image)
    
    if [ -z "$installer_image" ]; then
        error "Could not extract installer image from generated config"
        return 1
    fi
    
    log "Starting Talos upgrade to version v${desired_version}..."
    log "Using installer image: $installer_image"
    warn "Upgrading nodes sequentially to maintain cluster availability"
    
    for node_info in "${NODES[@]}"; do
        local hostname="${node_info%%:*}"
        local ip="${node_info##*:}"
        
        log "Upgrading $hostname ($ip) to v${desired_version}..."
        
        if talosctl --talosconfig "$talosconfig" \
            --endpoints "$endpoints" \
            upgrade \
            --nodes "$ip" \
            --image "$installer_image" \
            --wait; then
            success "Node $hostname upgraded successfully"
            log "Waiting 30 seconds for node to stabilize..."
            sleep 30
        else
            error "Failed to upgrade node $hostname"
            return 1
        fi
    done
    
    success "All nodes upgraded to Talos v${desired_version}"
}

# Main function
main() {
    log "Starting Talos auto-update process..."
    
    check_talhelper
    check_talosctl
    
    # Generate new configs first
    if ! generate_configs; then
        error "Failed to generate configs"
        exit 1
    fi
    
    # Check if only Talos version changed (requires upgrade)
    local current_talos_version
    local desired_talos_version
    local desired_kubernetes_version
    
    current_talos_version=$(get_current_talos_version)
    desired_talos_version=$(get_desired_talos_version)
    desired_kubernetes_version=$(get_desired_kubernetes_version)
    
    log "Current Talos version: v${current_talos_version}"
    log "Desired Talos version: v${desired_talos_version}"
    log "Desired Kubernetes version: v${desired_kubernetes_version}"
    
    if [ "$current_talos_version" != "$desired_talos_version" ] && [ "$current_talos_version" != "unknown" ]; then
        log "Talos version change detected, performing upgrade..."
        if upgrade_talos "$desired_talos_version"; then
            success "Talos upgrade completed successfully!"
        else
            error "Talos upgrade failed!"
            exit 1
        fi
    else
        log "No Talos version change detected (Kubernetes version or config change), applying configuration..."
        if apply_configs; then
            success "Configuration update completed successfully!"
        else
            error "Configuration update failed!"
            exit 1
        fi
    fi
    
    success "Talos auto-update process completed!"
}

main "$@"
