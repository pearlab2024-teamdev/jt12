	ORIGIN_PATH = $(shell pwd)
	PROJ_FILE_PATH = ./ym2203_project/ym2203_project.xpr
	BOARD_LOG_FILE = board_log_file.log
	TARGET_BOARD = nexys_video
	PATH_INVALID = 1

.PHONY: board

all: sub_module genproj openproj

sub_module:
	cd ..
	git submodule update --init --recursive

#board:
#	vivado -mode batch -source ./script/board_inst.tcl -tclargs $(TARGET_BOARD)| tee $(BOARD_LOG_FILE)
#	@if grep -q "Board part '$(TARGET_BOARD)' does not exist." $(BOARD_LOG_FILE); then \
#		echo "install '$(TARGET_BOARD)' file."; \
#		mkdir -p board; \
#		cd board; \
#		git clone https://github.com/Digilent/vivado-boards; \
#		cd $(ORIGIN_PATH); \
#		vivado -mode batch -source ./script/board_inst.tcl -tclargs $(TARGET_BOARD) $(PATH_INVALID); \
#	else \
#		echo "Board part '$(TARGET_BOARD)' found."; \
#	fi
#	rm $(BOARD_LOG_FILE)
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
