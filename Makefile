NAME := MeshFix

SYSTEM  != python -c "import platform; print(platform.system().lower())"
MACHINE != python -c "import platform; print(platform.machine().lower())"

SRC       := MeshFix-V2.1
BIN_DIR   := $(SRC)/bin64
BUILD_DIR := build
DIST_DIR  := dist

ifeq ($(SYSTEM), windows)
  EXE         := .exe
  TARGET      := $(BIN_DIR)/Debug/$(NAME)$(EXE)
  TARGET_DIST := $(DIST_DIR)/$(NAME)-$(SYSTEM)-$(MACHINE)$(EXE)
else
  EXE         :=
  TARGET      := $(BIN_DIR)/$(NAME)$(EXE)
  TARGET_DIST := $(DIST_DIR)/$(NAME)-$(SYSTEM)-$(MACHINE)$(EXE)
endif

all: $(TARGET)

clean:
	@ $(RM) --recursive --verbose $(BUILD_DIR)
	@ $(RM) --recursive --verbose $(DIST_DIR)
	@ $(RM) --verbose $(TARGET)

dist: $(TARGET_DIST)

#####################
# Auxiliary Targets #
#####################

$(TARGET):
	cmake -S $(SRC) -B $(BUILD_DIR)
	cmake --build $(BUILD_DIR) --parallel

$(TARGET_DIST): $(TARGET)
	@ mkdir --parents --verbose $(@D)
	@ install -D --no-target-directory --verbose $< $@
