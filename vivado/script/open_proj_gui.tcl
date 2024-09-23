set proj_path {./ym2203_project}
set proj_xpr {ym2203_project.xpr}
# デフォルトのパスを設定
set origin_path [pwd]

cd $proj_path
open_project $proj_xpr
start_gui
cd $origin_path