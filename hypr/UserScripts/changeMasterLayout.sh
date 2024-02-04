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
                    hyprctl dispatch "layoutmsg mfact 0.45" ; hyprctl dispatch "layoutmsg orientationcenter" # ; hyprctl reload
                    ;;
            esac
            ;;

        changefloatingmode* )
            workspace_info=$(hyprctl activeworkspace -j)
            workspace_id=$(echo "$workspace_info" | jq -r '.id')
            workspace_name=$(echo "$workspace_info" | jq -r '.name')
            clients_info=$(hyprctl clients -j)
            matching_windows=$(echo "$clients_info" | jq -r --arg workspace_id "$workspace_id" --arg workspace_name "$workspace_name" 'map(select(.workspace.id == ($workspace_id | tonumber) and .workspace.name == $workspace_name and .floating == false)) | length')

            # echo "Matching non-floating windows for workspace $workspace_name (ID: $workspace_id): $matching_windows"

            case $matching_windows in
                1)
                    hyprctl dispatch "layoutmsg mfact 0.65" ; hyprctl dispatch "layoutmsg orientationcenter" #  ; hyprctl reload
                    ;;
                2)
                    hyprctl dispatch "layoutmsg mfact 0.5"  ; hyprctl dispatch "layoutmsg orientationright"  # ; hyprctl reload
                    ;;
                *)
                    hyprctl dispatch "layoutmsg mfact 0.45" ; hyprctl dispatch "layoutmsg orientationcenter" # ; hyprctl reload
                    ;;
            esac

            # changefloatingmode에 대한 처리
            mode=$(echo "$1" | awk -F',' '{print $NF}')
            if [ "$mode" = "1" ]; then
                # echo "Changing floating mode to 1"
                # 크기를 변경
                hyprctl dispatch "centerwindow" ; hyprctl dispatch "resizeactive exact 2000 1600"

            # elif [ "$mode" = "0" ]; then
                # echo "Changing floating mode to 0"
            # else
                # echo "Invalid mode: $mode"
            fi
        # *)
        #     # echo "undefined command: $1"
        #     exit 0
    esac
}

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    handle "$line"
done
