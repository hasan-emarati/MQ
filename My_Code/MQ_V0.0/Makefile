## Select one of these
#DEVICE = stm8s003f3
DEVICE = stm8s103f3

## Directories
SRCDIR = src
LIBDIR = lib
OUTDIR = out

## Get program name from enclosing directory name
PROGRAM = $(lastword $(subst /, ,$(CURDIR)))

SOURCES = $(wildcard $(SRCDIR)/*.c)
LIBRARIES = $(wildcard $(LIBDIR)/*.c)
ALL_SOURCES = $(SOURCES) $(LIBRARIES)
OBJECTS = $(addprefix $(OUTDIR)/, $(notdir $(ALL_SOURCES:.c=.rel)))
HEADERS = $(wildcard $(LIBDIR)/*.h)

## Tools
CC = sdcc
PROGRAMMER = stlinkv2
OBJCOPY = objcopy
PACKIHX = packihx

## Compiler flags
DEFINES = -D$(DEVICE)
CPPFLAGS = -I$(LIBDIR)
CFLAGS = --Werror --std-sdcc99 -mstm8 $(DEFINES)
LDFLAGS = -mstm8 --out-fmt-ihx
LDLIBS = -lstm8

.PHONY: all clean flash hex size dirs help

all: dirs $(OUTDIR)/$(PROGRAM).hex

dirs:
	@if not exist $(OUTDIR) mkdir $(OUTDIR)

help:
	@echo "========================================"
	@echo "STM8 Makefile Help"
	@echo "========================================"
	@echo "Available targets:"
	@echo "  make all      - Build the project"
	@echo "  make hex      - Generate hex file only"
	@echo "  make flash    - Flash to MCU"
	@echo "  make clean    - Remove build files"
	@echo "  make rebuild  - Clean and rebuild"
	@echo "  make info     - Show configuration"
	@echo "  make size     - Show memory usage"
	@echo "  make help     - Show this help"
	@echo "========================================"

hex: $(OUTDIR)/$(PROGRAM).hex

rebuild: clean all

$(OUTDIR)/$(PROGRAM).hex: $(OUTDIR)/$(PROGRAM).ihx
	@echo "Converting to HEX..."
	packihx $< > $@
	@echo "OK HEX: $@"
	@echo "Build complete!"

$(OUTDIR)/$(PROGRAM).ihx: $(OBJECTS)
	@echo "Linking..."
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@
	@echo "OK Linked: $@"
	@echo ""

$(OUTDIR)/%.rel: $(SRCDIR)/%.c $(HEADERS)
	@echo "Compiling $<..."
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
	@echo "OK Compiled: $(notdir $@)"

$(OUTDIR)/%.rel: $(LIBDIR)/%.c $(HEADERS)
	@echo "Compiling $<..."
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
	@echo "OK Compiled: $(notdir $@)"

clean:
	@echo "Cleaning..."
	@if exist $(OUTDIR) rmdir /s /q $(OUTDIR)
	@echo "OK Clean done"

flash: $(OUTDIR)/$(PROGRAM).hex
	@echo "========================================"
	@echo "Flashing to $(DEVICE)..."
	@echo "========================================"
	stm8flash -c $(PROGRAMMER) -p $(DEVICE) -w $<
	@echo "OK Flash done"

flash-erase: 
	@echo "Erasing $(DEVICE)..."
	stm8flash -c $(PROGRAMMER) -p $(DEVICE) -s erase
	@echo "OK Erase done"

info:
	@echo "========================================"
	@echo "Project Configuration"
	@echo "========================================"
	@echo "  Device:      $(DEVICE)"
	@echo "  Program:     $(PROGRAM)"
	@echo "  Source dir:  $(SRCDIR)"
	@echo "  Library dir: $(LIBDIR)"
	@echo "  Output dir:  $(OUTDIR)"
	@echo "  Sources:     $(SOURCES)"
	@echo "  Libraries:   $(LIBRARIES)"
	@echo "  Headers:     $(HEADERS)"
	@echo "  Objects:     $(OBJECTS)"
	@echo "========================================"

size: $(OUTDIR)/$(PROGRAM).ihx
	@echo "========================================"
	@echo "Memory Usage Report"
	@echo "========================================"
	$(CC) -mstm8 --code-loc 0x8000 --code-size 0x8000 \
		--out-fmt-ihx $(OBJECTS) -o $(OUTDIR)/temp.ihx \
		2>&1 | findstr /i "code size data stack"
	@if exist $(OUTDIR)\temp.ihx del $(OUTDIR)\temp.ihx
	@echo "========================================"

# Quick build check
check: all
	@echo "Checking hex file..."
	@if exist $(OUTDIR)\$(PROGRAM).hex ( \
		echo OK Hex file exists && \
		echo "  Size: " && \
		dir $(OUTDIR)\$(PROGRAM).hex | findstr $(PROGRAM).hex \
	) else ( \
		echo ERROR: Hex file not created \
	)
	@echo ""

# Default target
.DEFAULT_GOAL := all