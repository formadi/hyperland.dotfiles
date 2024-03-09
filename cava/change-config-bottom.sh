#!/bin/bash

# 원본 파일 경로
original_config="/home/elsa/.cache/wal/cava-colors"

# 복사 대상 파일 경로
target_config="/home/elsa/.config/cava/config-bottom"

# 원하는 변경 내용
# change1="channels = mono"
# change2="mono_option = left"

# 원본 파일을 복사하여 대상 파일로 생성
cp "$original_config" "$target_config"

# 보색 계산 함수
complementary_color() {
    color_hex=$1
    # '#' 제거
    color_hex=${color_hex#"#"}
    # 16진수 RGB를 10진수로 변환하여 계산
    # echo "$color_hex"

    red=$((16#${color_hex:0:2}))
    green=$((16#${color_hex:2:2}))
    blue=$((16#${color_hex:4:2}))
    # 보색 계산
    red_comp=$(printf "%02x" $((255 - red)))
    green_comp=$(printf "%02x" $((255 - green)))
    blue_comp=$(printf "%02x" $((255 - blue)))
    # 보색 코드 반환
    echo "$red_comp$green_comp$blue_comp"
}

# sed를 사용하여 변경 내용 적용
# sed -i "s/; channels = stereo/$change1/g" "$target_config"
# sed -i "s/; mono_option = average/$change2/g" "$target_config"

# 보색처리
# 설정값 추출 및 보색 계산하여 변경
for i in {1..8}; do
    original_color=$(grep -oP "gradient_color_${i} = '\K[^']+" "$original_config")
    complementary_color_code=$(complementary_color "$original_color")
    sed -i "s/gradient_color_${i} = '${original_color}'/gradient_color_${i} = '#${complementary_color_code}'/g" "$target_config"
done


original_color=$(grep -oP "foreground = '\K[^']+" "$original_config")
complementary_color_code=$(complementary_color "$original_color")
sed -i "s/foreground = '${original_color}'/foreground = '#${complementary_color_code}'/g" "$target_config"

echo "변경이 완료되었습니다."
