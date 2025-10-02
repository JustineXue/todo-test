#!/bin/bash
set -e

# Directories
ARTIFACT_DIR="../artifacts"

echo "📥 Fetching latest test-output artifact from GitHub Actions..."

# Download the latest artifact named "test-output"
gh run download --name "test-output" --dir "$ARTIFACT_DIR"

# Verify the file exists
TEST_OUTPUT_FILE="$ARTIFACT_DIR/test-output.txt"
if [[ -f "$TEST_OUTPUT_FILE" ]]; then
    echo "✅ Test results downloaded to $TEST_OUTPUT_FILE"
    echo
    echo "📄 Test output preview:"
    echo "--------------------------------"
    tail -n 20 "$TEST_OUTPUT_FILE"
    echo "--------------------------------"
else
    echo "❌ Could not find test-output.txt in artifact."
    exit 1
fi

# Run Trivy scan and save JSON results
TRIVY_OUTPUT_FILE="$ARTIFACT_DIR/trivy-results.json"
echo
echo "🔍 Running Trivy scan and saving results to $TRIVY_OUTPUT_FILE..."
trivy fs --format json . > "$TRIVY_OUTPUT_FILE"

if [[ -f "$TRIVY_OUTPUT_FILE" ]]; then
    echo "✅ Trivy results saved to $TRIVY_OUTPUT_FILE"
else
    echo "❌ Trivy scan failed or output not found."
    exit 1
fi
