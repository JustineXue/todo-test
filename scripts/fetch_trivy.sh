#!/bin/bash
set -e

# Directories
ARTIFACT_DIR="../artifacts"

echo "📥 Fetching latest trivy-security-results artifact from GitHub Actions..."

# Download the latest artifact named "test-output"
gh run download --name "trivy-security-results" --dir "$ARTIFACT_DIR"

# Verify the file exists
SCAN_OUTPUT_FILE="$ARTIFACT_DIR/trivy-results.json"
if [[ -f "$SCAN_OUTPUT_FILE" ]]; then
    echo "✅ Security scan results downloaded to $SCAN_OUTPUT_FILE"
    echo
    echo "📄 Trivy output preview:"
    echo "--------------------------------"
    tail -n 20 "$SCAN_OUTPUT_FILE"
    echo "--------------------------------"
else
    echo "❌ Could not find trivy-results.json in artifact."
    exit 1
fi

# # Run Trivy scan and save JSON results
# TRIVY_OUTPUT_FILE="$ARTIFACT_DIR/trivy-results.json"
# echo
# echo "🔍 Running Trivy scan and saving results to $TRIVY_OUTPUT_FILE..."
# trivy fs --format json . > "$TRIVY_OUTPUT_FILE"

# if [[ -f "$TRIVY_OUTPUT_FILE" ]]; then
#     echo "✅ Trivy results saved to $TRIVY_OUTPUT_FILE"
# else
#     echo "❌ Trivy scan failed or output not found."
#     exit 1
# fi
