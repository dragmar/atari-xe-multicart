CC = cl65
CFLAGS = -v -tatari 

LINKER_CONFIG = src/menu.cfg
LDFLAGS = -C$(LINKER_CONFIG)

export CC65_INC = /usr/share/cc65/include/
export CA65_INC = /usr/share/cc65/asminc/
export LD65_LIB = /usr/share/cc65/lib/
export LD65_OBJ = /usr/share/cc65/lib/
export LD65_CFG = /usr/share/cc65/cfg/

VPATH = src
SRC = src/menu.c

ROMS = roms/*

MENU_CONFIG = src/games.c
MENU = menu.bin
TARGET = cart.bin

all: $(TARGET)

$(TARGET): $(MENU)
	  ./buildcart.py --menu $^ $(ROMS) > $@

$(MENU): $(SRC) $(MENU_CONFIG)
	  $(CC) $(CFLAGS) $(SRC) $(LDFLAGS) -m $@.map -o $@

$(MENU_CONFIG):
	 ./buildcart.py --config $(ROMS) > $@

.PHONY: clean
clean:
	 $(RM) $(MENU_CONFIG)
	 $(RM) $(MENU).map
	 $(RM) $(MENU)
	 $(RM) $(TARGET)
	 $(RM) src/*.o
