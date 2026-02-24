#!/bin/bash
set -e

MOD_DIR="/media/Backup/Steam Games/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro/Mods/SlayTheJokers"
BIN_DIR="${MOD_DIR}/bin"
VENV_DIR="${MOD_DIR}/venv"

mkdir -p "${BIN_DIR}"

# Download uv standalone binary (tar.gz) – once
if [ ! -f "${BIN_DIR}/uv" ]; then
    echo "BIN_DIR: ${BIN_DIR}"
    TARBALL="${BIN_DIR}/uv.tar.gz"
    echo "Tarball path: ${TARBALL}"

    # If tarball already exists and has size, skip redownload
    if [ ! -f "${TARBALL}" ] || [ ! -s "${TARBALL}" ]; then
        echo "Downloading fresh uv tarball (version 0.10.5)..."
        curl -L https://github.com/astral-sh/uv/releases/download/0.10.5/uv-x86_64-unknown-linux-gnu.tar.gz -o "${TARBALL}"
    else
        echo "Reusing existing uv.tar.gz (${TARBALL})"
    fi

    # Debug: confirm file exists and show size
    ls -lh "${TARBALL}" || { echo "ls failed – check permissions on ${BIN_DIR}"; exit 1; }

    echo "Attempting extraction from ${TARBALL} into ${BIN_DIR}/ (with strip-components=1)"

    # Extract, stripping the top-level directory (uv-x86_64-unknown-linux-gnu/)
    tar -xzf "${TARBALL}" --strip-components=1 -C "${BIN_DIR}/"

    # Immediate check
    if [ -f "${BIN_DIR}/uv" ]; then
        chmod +x "${BIN_DIR}/uv"
        echo "SUCCESS: uv extracted and executable at ${BIN_DIR}/uv"
        echo "Size: $(du -h "${BIN_DIR}/uv" | cut -f1)"
        rm -f "${TARBALL}"
    else
        echo "Extraction failed. Listing directory:"
        ls -la "${BIN_DIR}"
        echo "Tar contents for reference:"
        tar -tzf "${TARBALL}" || echo "Cannot read tarball"
        echo ""
        echo "Manual fix command (run this):"
        echo "  tar -xzf \"${TARBALL}\" --strip-components=1 -C \"${BIN_DIR}/\""
        echo "  chmod +x \"${BIN_DIR}/uv\""
        echo "  rm -f \"${TARBALL}\""
        exit 1
    fi
else
    echo "uv already present – skipping download/extract"
fi

# Isolated venv + deps (once)
if [ ! -d "${VENV_DIR}" ]; then
    echo "Setting up Python venv..."
    "${BIN_DIR}/uv" venv "${VENV_DIR}" --python 3.12
fi

echo "Installing dependencies..."
"${BIN_DIR}/uv" pip install --python "${VENV_DIR}/bin/python" "certifi==2025.1.31" psutil requests

echo "Starting Slay the Jokers uploader..."
exec "${VENV_DIR}/bin/python" "${MOD_DIR}/stj_uploader.py"
