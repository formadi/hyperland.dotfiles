#!/bin/sh

handle() {
    case $1 in
        openwindow*|closewindow*)
            sleep 0.1
            workspace_info=$(hyprctl activeworkspace -j)
            workspace_id=$(echo "$workspace_info" | jq -r '.id')
            workspace_name=$(echo "$workspace_info" | jq -r '.name')
            clients_info=$(hyprctl clients -j)
            matching_windows=$(echo "$clients_info" | jq -r --arg workspace_id "$workspace_id" --arg workspace_name "$workspace_name" 'map(select(.workspace.id == ($workspace_id | tonumber) and .workspace.name == $workspace_name and .floating == false)) | length')

            # echo "Matching non-floating windows for workspace $workspace_name (ID: $workspace_id): $matching_windows"

            case $matching_windows in
                1)
                    hyprctl dispatch "layoutmsg mfact 0.65" ; hyprctl dispatch "layoutmsg orientationcenter" # ; hyprctl reload
                    ;;
                2)
                    hyprctl dispatch "layoutmsg mfact 0.5"  ; hyprctl dispatch "layoutmsg orientationright"  # ; hyprctl reload
                    ;;
                *)
                    hyprctl dispatch "layoutmsg mfact 0.4"  ; hyprctl dispatch "layoutmsg orientationcenter" # ; hyprctl reload
                    ;;
            esac
            ;;

        changefloatingmode* )
            workspace_info=$(hyprctl activeworkspace -j)
            workspace_id=$(echo "$workspace_info" | jq -r '.id')
            workspace_name=$(echo "$workspace_info" | jq -r '.name')
            clients_info=$(hyprctl clients -j)
            matching_windows=$(echo "$clients_info" | jq -r --arg workspace_id "$workspace_id" --arg workspace_name "$workspace_name" 'map(select(.workspace.id == ($workspace_id | tonumber) and .workspace.name == $workspace_name and .floating == false)) | length')

            activewindowInfo=$(hyprctl activewindow -j)
            at_value=$(echo "$activewindowInfo" | grep -o '"at": \[[0-9]*, [0-9]*\]' | sed 's/"at": \[\([0-9]*, [0-9]*\)\]/\1/')
            x_coord=$(echo "$at_value" | awk -F', ' '{print $1}')
            y_coord=$(echo "$at_value" | awk -F', ' '{print $2}')

            # echo "Matching non-floating windows for workspace $workspace_name (ID: $workspace_id): $matching_windows"

            case $matching_windows in
                1)
                    hyprctl dispatch "layoutmsg mfact 0.65" ; hyprctl dispatch "layoutmsg orientationcenter" #  ; hyprctl reload
                    ;;
                2)
                    hyprctl dispatch "layoutmsg mfact 0.5"  ; hyprctl dispatch "layoutmsg orientationright"  # ; hyprctl reload
                    ;;
                *)
                    hyprctl dispatch "layoutmsg mfact 0.4"  ; hyprctl dispatch "layoutmsg orientationcenter" # ; hyprctl reload
                    ;;
            esac

            # changefloatingmode에 대한 처리
            mode=$(echo "$1" | awk -F',' '{print $NF}')

            # entrance to floatingmode
            if [ "$mode" = "1" ]; then
                # floating window의 x좌표값을 저장함.
                # 이것은 floating 하기 직전의 좌표임.
                echo "$x_coord" > /tmp/floatingwindX.txt
                # echo "$y_coord" > /tmp/floatingwindY.txt

                # echo "Changing floating mode to 1"
                # 크기를 변경
                # hyprctl dispatch "centerwindow" ; hyprctl dispatch "resizeactive exact 2000 1600"
                hyprctl dispatch "resizeactive exact 2000 1700" ; hyprctl dispatch "centerwindow"

            # exit from floatingmode
            elif [ "$mode" = "0" ]; then
              stored_x_coord=$(cat /tmp/floatingwindX.txt)
              # stored_y_coord=$(cat /tmp/floatingwindY.txt)
              hyprctl movewindow $stored_x_coord, $stored_y_coord
              if [ $stored_x_coord -eq 2036 ]; then
                echo "오른쪽 윈도우로 복귀"
                hyprctl dispatch "layoutmsg swapprev"
              elif [ $stored_x_coord -eq 800 ]; then
                echo "가운데 윈도우로 복귀"
                hyprctl dispatch "layoutmsg swapprev" ; hyprctl dispatch "layoutmsg swapprev"
              fi
              # 왼쪽 윈도우의 경우 아무런 조치를 하지 않아도 됨.
            fi
        # *)
        #     # echo "undefined command: $1"
        #     exit 0
    esac
}

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
  echo "$line"
  handle "$line"
done
