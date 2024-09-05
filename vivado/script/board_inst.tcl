# ボードパート名を指定
set target_board [get_board_parts -quiet -latest_file_version "*nexys_video*"]

# ボードパートのリストを取得
set board_parts [get_board_parts]

# フラグを初期化
set board_exists 0

# デフォルトのパスを設定
set origin_path [pwd]

# ボードパートが存在するかどうかをチェック
foreach board $board_parts {
    if { $board == $target_board } {
        set board_exists 1
        break
    }
}

# 結果を表示
if { $board_exists } {
    puts "Board part '$target_board' exists."
} else {
    puts "Board part '$target_board' does not exist."
    exec mkdir board
    cd board
    exec git clone https://github.com/Digilent/vivado-boards
    set_param board.repoPaths {vivado-boards/new/board_files}
    cd $origin_path
    puts "install Board part '$target_board'."
}
