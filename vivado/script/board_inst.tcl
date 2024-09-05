set target_board [lindex $argv 0]
set path_invalid [lindex $argv 1]

# ボードパート名を指定
set get_target_board [get_board_parts -quiet -latest_file_version "*${target_board}*"]

# ボードパートのリストを取得
set board_parts [get_board_parts]

# フラグを初期化
set board_exists 0

# デフォルトのパスを設定
set origin_path [pwd]

# ボードパートが存在するかどうかをチェック
foreach board $board_parts {
    if { $board == $get_target_board } {
        set board_exists 1
        break
    }
}

# vivadoのパスを通す。
if {$path_invalid == 1} {
    cd board
    set_param board.repoPaths {vivado-boards/new/board_files}
    cd $origin_path
    puts "Complete setting board part files's path."
}

# 結果を表示
if { $board_exists } {
    puts "Board part '$target_board' exists."
} else {
    puts "Board part '$target_board' does not exist."
}
