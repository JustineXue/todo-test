#!/bin/bash
set -e

# Directory to store artifacts
ARTIFACT_DIR="../artifacts"

# Ensure clean directory
rm -rf "$ARTIFACT_DIR"
mkdir -p "$ARTIFACT_DIR"

echo "📥 Fetching latest test-output artifact from GitHub Actions..."

# Download the latest artifact named "test-output"
gh run download --name "test-output" --dir "$ARTIFACT_DIR"

# Verify the file exists
if [[ -f "$ARTIFACT_DIR/test-output.txt" ]]; then
    echo "✅ Test results downloaded to $ARTIFACT_DIR/test-output.txt"
    echo
    echo "📄 Test output preview:"
    echo "--------------------------------"
    tail -n 20 "$ARTIFACT_DIR/test-output.txt"
    echo "--------------------------------"
else
    echo "❌ Could not find test-output.txt in artifact."
    exit 1
fi

# Optional: Pipe into your LLM script
# cat "$ARTIFACT_DIR/test-output.txt" | python your_llm_script.py
