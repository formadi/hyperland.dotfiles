#!/bin/bash

# 원본 파일 경로
original_config="/home/elsa/.cache/wal/cava-colors"

# 복사 대상 파일 경로
target_config="/home/elsa/.config/cava/config-right"

# 원하는 변경 내용
change1="channels = mono"
change2="mono_option = right"

# 원본 파일을 복사하여 대상 파일로 생성
cp "$original_config" "$target_config"

# sed를 사용하여 변경 내용 적용
sed -i "s/; channels = stereo/$change1/g" "$target_config"
sed -i "s/; mono_option = average/$change2/g" "$target_config"

echo "변경이 완료되었습니다."
