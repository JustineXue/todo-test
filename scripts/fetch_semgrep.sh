#!/bin/bash
set -e

# Directories
ARTIFACT_DIR="../artifacts"

echo "📥 Fetching latest semgrep-security-results artifact from GitHub Actions..."

# Download the latest artifact named "semgrep-security-results"
gh run download --name "semgrep-security-results" --dir "$ARTIFACT_DIR"

# Verify the file exists
SCAN_OUTPUT_FILE="$ARTIFACT_DIR/semgrep-report.txt"
if [[ -f "$SCAN_OUTPUT_FILE" ]]; then
    echo "✅ Security scan results downloaded to $SCAN_OUTPUT_FILE"
    echo
    echo "📄 Semgrep output preview:"
    echo "--------------------------------"
    tail -n 20 "$SCAN_OUTPUT_FILE"
    echo "--------------------------------"
else
    echo "❌ Could not find semgrep-report.txt in artifact."
    exit 1
fi