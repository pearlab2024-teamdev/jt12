	ORIGIN_PATH = $(shell pwd)
	PROJ_FILE_PATH = ./ym2203_project/ym2203_project.xpr

all: sub_module board genproj openproj

sub_module:
	cd ..
	git submodule update --init --recursive

board:
	vivado -mode batch -source ./script/board_inst.tcl

genproj:
	@if [ -e $(PROJ_FILE_PATH) ]; then \
		echo "$(PROJ_FILE_PATH) exists."; \
	else \
		echo "$(PROJ_FILE_PATH) not found."; \
		vivado -mode batch -source ym2203_project_regen.tcl;\
	fi

openproj:
	vivado -mode batch -source ./script/open_proj_gui.tcl -tclargs
	vivado -mode batch -source ./script/gen_proj_regen_script.tcl -tclargs

genscript:
	vivado -mode batch -source ./script/gen_proj_regen_script.tcl -tclargs
