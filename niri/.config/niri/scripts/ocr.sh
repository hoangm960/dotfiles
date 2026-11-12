#!/bin/bash

# Capture selected region to stdout and pipe to Tesseract (English + Vietnamese)
text=$(dms screenshot region --no-confirm --stdout --no-file --no-clipboard --no-notify 2>/dev/null \
  | tesseract - - -l eng+vie 2>/dev/null)

# Trim leading/trailing empty lines and spaces
text=$(printf "%s" "$text" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

if [[ -n "$text" ]]; then
    printf "%s" "$text" | wl-copy
    dms notify "OCR Copied" "$text"
else
    dms notify "OCR" "No text detected"
fi
