RM_BINARY=rm
RM_FLAGS=-rf
MKDIR_BINARY=mkdir
MKDIR_FLAGS=-p
NASM_BINARY=nasm
NASM_FLAGS=-f bin -i lib

BUILD_FOLDER=bin

.DEFAULT_GOAL := default

DIR = $(abspath src)
INPUTS = $(wildcard $(DIR)/*.asm)

# Create the build folder
$(BUILD_FOLDER):
	$(MKDIR_BINARY) $(MKDIR_FLAGS) $(@)

# Compiles all ASM files in a given directory
$(INPUTS) : $(BUILD_FOLDER)
	$(NASM_BINARY) $(NASM_FLAGS) -o $(patsubst $(DIR)/%.asm,$(BUILD_FOLDER)/%.com,$(@)) -l $(patsubst $(DIR)/%.asm,$(BUILD_FOLDER)/%.list,$(@)) $@

default: clean all

all: $(INPUTS)

clean:
	$(RM_BINARY) $(RM_FLAGS) $(BUILD_FOLDER)
