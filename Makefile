# Variables
CC = gcc
CFLAGS = -Wall -Wextra -g --pedantic
LDFLAGS = -lmagic  # Links libmagic to the compiler

# Source file paths
SRC = src/sfile.c src/sfile_utility.c # Changed to the src folder
OUT = build/sfile
DEST = sfile 

# Default target
all: $(OUT)

# Compilation
$(OUT): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $(OUT) $(LDFLAGS)

# Installation
install: $(OUT)
	@echo "Installing sfile..."
	@sudo install -Dm755 $(OUT) /usr/local/bin/$(DEST)
	@sudo install -Dm644 man/sfile.1 /usr/local/share/man/man1/sfile.1  # Changed to the man folder

# Uninstallation
uninstall:
	@echo "Uninstalling sfile..."
	@sudo rm -f /usr/local/bin/sfile
	@sudo rm -f /usr/local/share/man/man1/sfile.1

# Cleaning build files
clean:
	@echo "Cleaning up..."
	@rm -f $(OUT)

