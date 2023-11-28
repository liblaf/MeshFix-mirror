NAME := MeshFix

SYSTEM  != python -c "import platform; print(platform.system().lower())"
MACHINE != python -c "import platform; print(platform.machine().lower())"

SRC       := MeshFix-V2.1
BIN_DIR   := $(SRC)/bin64
BUILD_DIR := build
DIST_DIR  := dist

ifeq ($(SYSTEM), windows)
EXE    := .exe
TARGET := $(BIN_DIR)/Debug/$(NAME)$(EXE)
else
EXE    :=
TARGET := $(BIN_DIR)/$(NAME)$(EXE)
endif
TARGET_DIST := $(DIST_DIR)/$(NAME)-$(SYSTEM)-$(MACHINE)$(EXE)

all: $(TARGET)

clean:
	@ rm --force --recursive --verbose $(BUILD_DIR)
	@ rm --force --recursive --verbose $(DIST_DIR)
	@ rm --force --verbose $(TARGET)

dist: $(TARGET_DIST)

###############
# Auxiliaries #
###############

$(TARGET):
	cmake -S $(SRC) -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR) --parallel

$(TARGET_DIST): $(TARGET)
	@ install -D --no-target-directory --verbose $< $@
