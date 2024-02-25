NAME    := MeshFix
SRC_DIR := MeshFix-V2.1

RUNNER_OS   ?= $(shell uname -s)
RUNNER_ARCH ?= $(shell uname -m)

override RUNNER_OS   != echo "$(RUNNER_OS)" | tr '[:upper:]' '[:lower:]'
override RUNNER_ARCH != echo "$(RUNNER_ARCH)" | tr '[:upper:]' '[:lower:]'

EXE := $(if $(filter windows,$(RUNNER_OS)),.exe,)

ifeq ($(RUNNER_OS),windows)
OUTPUT := $(SRC_DIR)/bin64/Debug/$(NAME)$(EXE)
else
OUTPUT := $(SRC_DIR)/bin64/$(NAME)$(EXE)
endif

default: $(OUTPUT)
	cmake -S "$(SRC_DIR)" -B "build"
	cmake --build "build" --parallel

clean:
	git -C "$(SRC_DIR)" clean -d --force -x
	git clean -d --force -X

.PHONY: dist
dist: dist/$(NAME)-$(RUNNER_OS)-$(RUNNER_ARCH)$(EXE)

#####################
# Auxiliary Targets #
#####################

$(OUTPUT):
	cmake -S "$(SRC_DIR)" -B "build"
	cmake --build "build" --parallel

dist/$(NAME)-$(RUNNER_OS)-$(RUNNER_ARCH)$(EXE): $(OUTPUT)
	install -D --no-target-directory --verbose "$<" "$@"
