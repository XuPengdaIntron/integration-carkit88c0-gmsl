#!/bin/bash

# Test all 20 radar modes from radar_mode_tbls.h / DTSI

MODES=(
    "0:1024:256"
    "1:2048:256"
    "2:4096:256"
    "3:8192:256"
    "4:16384:256"
    "5:1024:512"
    "6:2048:512"
    "7:4096:512"
    "8:8192:512"
    "9:16384:512"
    "10:1024:640"
    "11:2048:640"
    "12:4096:640"
    "13:8192:640"
    "14:16384:640"
    "15:1024:1024"
    "16:2048:1024"
    "17:4096:1024"
    "18:8192:1024"
    "19:16384:1024"
)

DEVICE="/dev/video0"
PIXEL_FORMAT="RG12"
OUTPUT_DIR="/tmp/radar_test"
STREAM_COUNT=5

rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

echo "============================================"
echo "Testing all radar modes (stream-count=$STREAM_COUNT)"
echo "============================================"

for entry in "${MODES[@]}"; do
    IFS=':' read -r idx width height <<< "$entry"
    OUTPUT_FILE="${OUTPUT_DIR}/mode${idx}_${width}x${height}.raw"
    
    echo ""
    echo "--- Mode $idx: ${width}x${height} ---"
    
    timeout 10 v4l2-ctl -d $DEVICE \
        --set-fmt-video=width=$width,height=$height,pixelformat=$PIXEL_FORMAT \
        --stream-mmap \
        --stream-count=$STREAM_COUNT \
        --stream-to=$OUTPUT_FILE \
        --set-ctrl bypass_mode=0 \
        2>&1
    
    EXIT_VALUE=$?
    if [ $EXIT_VALUE -eq 0 ]; then
        FILESIZE=$(stat -c%s "$OUTPUT_FILE" 2>/dev/null || echo "0")
        EXPECTED=$((width * height * 2 * STREAM_COUNT))
        echo "  ✅ Mode $idx: SUCCESS ($FILESIZE bytes, expected ~$EXPECTED)"
    elif [ $EXIT_VALUE -eq 124 ]; then
        echo "  ⏰ Mode $idx: TIMEOUT"
    else
        echo "  ❌ Mode $idx: FAILED (exit=$EXIT_VALUE)"
    fi
done

echo ""
echo "============================================"
echo "Done. Results saved to $OUTPUT_DIR"
echo "============================================"

# Show summary
echo ""
echo "Summary:"
for entry in "${MODES[@]}"; do
    IFS=':' read -r idx width height <<< "$entry"
    OUTPUT_FILE="${OUTPUT_DIR}/mode${idx}_${width}x${height}.raw"
    if [ -f "$OUTPUT_FILE" ]; then
        FILESIZE=$(stat -c%s "$OUTPUT_FILE" 2>/dev/null || echo "0")
        echo "  Mode $idx (${width}x${height}): $FILESIZE bytes ✅"
    else
        echo "  Mode $idx (${width}x${height}): no file ❌"
    fi
done
