set proj_path {./ym2203_project}
set proj_xpr {ym2203_project.xpr}
# デフォルトのパスを設定
set origin_path [pwd]

cd $proj_path
open_project $proj_xpr
cd $origin_path
write_project_tcl -no_copy_sources -use_bd_files -force {ym2203_project_regen.tcl}