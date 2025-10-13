{ pkgs, ... }:

{
environment.variables.EDITOR = "edit";
  environment.systemPackages =
    with pkgs;
    [
      (writeShellScriptBin "sudoedit" ''
        #!${stdenv.shell}
        sudo -e "$@"
      '')

      (writeShellScriptBin "edit" ''
        #!${stdenv.shell}
        ${lunarvim}/bin/lvim "$@"
      '')

      (writeShellScriptBin "system-info" ''
        #!${stdenv.shell}
        ${fastfetch}/bin/fastfetch "$@"
      '')

      (writeShellScriptBin "repo-info" ''
        #!${stdenv.shell}
        ${onefetch}/bin/onefetch -d churn commits lines-of-code --no-color-palette --true-color never
        ${git}/bin/git status
      '')

      (writeShellScriptBin "todo" ''
        #!${stdenv.shell}
        if [ -z "$1" ]; then
            ${fasole}/bin/fasole TODO.md
        else
            ${fasole}/bin/fasole "$@"
        fi
      '')

      (writeShellScriptBin "stamp" ''
        #!${stdenv.shell}
        if [ "$#" -lt 1 ]; then
            echo "You need to provide at least one file as an argument."
            exit 1
        fi

        current_time=$(date "+%Y%m%d%H%M%S")
        echo "Current Time : $current_time"

        for file_name in "$@"; do
            new_fileName=$current_time-$file_name
            echo "New FileName: " "$new_fileName"
            cp -r "$file_name" "$new_fileName"
        done

        echo "You should see new files generated with timestamp on them.."
      '')

      (writeShellScriptBin "work" ''
        #!${stdenv.shell}
        branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        if [ $? -eq 128 ]; then
            echo "must be in a git repository to work!" >&2
            exit 1
        fi
        if [ -z "$1" ]; then
            ${fasole}/bin/fasole "$branch_name.md"
        else
            ${fasole}/bin/fasole "$@"
        fi
      '')

      (writeShellScriptBin "trash" ''
        #!${stdenv.shell}
        if [ "$1" = "-l" ]; then
          ${trash-cli}/bin/trash-list --trash-dir=$HOME/.Trash "''${@:2}"
        elif [ "$1" = "-e" ]; then
          if [ "$(uname)" = "Darwin" ]; then
            osascript -e 'tell application "Finder" to empty trash'
          else
            ${trash-cli}/bin/trash-empty --trash-dir=$HOME/.Trash "''${@:2}"
          fi
        elif [ "$1" = "-r" ]; then
          ${trash-cli}/bin/trash-restore --trash-dir=$HOME/.Trash "''${@:2}"
        else
          if [ "$(uname)" = "Darwin" ]; then
            files_to_move=""
            for file in "$@"; do
              abs_path=$(cd "$(dirname "$file")" && pwd)/$(basename "$file")
              files_to_move="$files_to_move, POSIX file \"$abs_path\""
            done
            files_to_move=''${files_to_move#, }
            osascript -e "tell application \"Finder\" to delete {$files_to_move}" &> /dev/null
          else
            ${trash-cli}/bin/trash --trash-dir=$HOME/.Trash "$@"
          fi
        fi
      '')

      (writeShellScriptBin "info" ''
        #!${stdenv.shell}
        if [ "$#" -ne 1 ]; then
            echo "error: expected exactly one file."
            exit 1
        fi

        file="$1"
        mime_type=$(file --mime-type --brief --dereference "$file")

        case "$mime_type" in
        audio/*)
            echo "This is a song."
            ;;
        video/*)
            ffprobe -hide_banner "$file"
            ;;
        image/*)
            echo "This is a photo."
            ;;
        text/*)
            case $(basename "$file") in
            *.md)
                ${glow}/bin/glow --style ~/.config/glow/default.json "$file"
                ;;
            *.csv)
                ${csvtool}/bin/csvtool readable "$file" | less
                ;;
            *)
                cat "$file"
                ;;
            esac
            ;;
        application/pdf)
            zathura "$file"
            ;;
        application/zip)
            echo "This is a zip archive."
            ;;
        application/x-tar)
            echo "This is a tar archive."
            ;;
        application/x-rar)
            echo "This is a rar archive."
            ;;
        application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
            echo "This is an Excel spreadsheet."
            ;;
        application/vnd.openxmlformats-officedocument.wordprocessingml.document)
            echo "This is a Word document."
            ;;
        *)
            echo "Filetype is unknown or unsupported."
            ;;
        esac
      '')
    ]
    ++ (if pkgs.stdenv.isLinux then [ ] else [ ]);
}
