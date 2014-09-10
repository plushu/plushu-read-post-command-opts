saved_args=()

# While there is a first argument
while [[ -n "${1+x}" ]]; do case "$1" in
  --)
    saved_args+=("$@")
    break
    ;;

  -)
    saved_args+=(-)
    shift
    ;;

  --*)
    opt="${1%%=*}"
    optfiles=("$PLUSHU_PLUGINS_ROOT/plugins"/*"/long-opts/${opt#--}")
    if [[ -n "${optfiles[@]}" ]]; then
      for optscript in "${optfiles[@]}"; do
        plugin_subpath=${optscript#$PLUSHU_PLUGINS_ROOT/plugins/}
        plugin_name=${plugin_subpath%%/*}
        PLUSHU_PLUGIN_NAME="$plugin_name" \
        PLUSHU_PLUGIN_PATH="$PLUSHU_PLUGINS_ROOT/plugins/$plugin_name" \
          source "$optscript"
      done
    else
      saved_args+=("$1")
      shift
    fi
    ;;

  -*)
    opt="${1:1:1}"
    optfiles=("$PLUSHU_PLUGINS_ROOT/plugins"/*"/short-opts/$opt")
    if [[ -n "${optfiles[@]}" ]]; then
      for optscript in "${optfiles[@]}"; do
        plugin_subpath=${optscript#$PLUSHU_PLUGINS_ROOT/plugins/}
        plugin_name=${plugin_subpath%%/*}
        PLUSHU_PLUGIN_NAME="$plugin_name" \
        PLUSHU_PLUGIN_PATH="$$PLUSHU_PLUGINS_ROOT/plugins/$plugin_name" \
          source "$optscript"
      done
    else
      saved_args+=("$1")
      shift
    fi
    ;;

  *)
    saved_args+=("$1")
    shift
    ;;
esac done

set -- "${saved_args[@]}"
