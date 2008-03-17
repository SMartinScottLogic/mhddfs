#    mhddfs - Multi HDD [FUSE] File System
#    Copyright (C) 2008 Dmitry E. Oboukhov <dimka@avanto.org>

#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

SRC	=	$(wildcard src/*.c)

OBJ	=	$(SRC:src/%.c=obj/%.o)

TARGET	=	mhddfs

CFLAGS	=	-Wall $(shell pkg-config fuse --cflags) -DFUSE_USE_VERSION=26
LDFLAGS	=	$(shell pkg-config fuse --libs)

all: $(TARGET)

$(TARGET): obj/obj-stamp $(OBJ)
	gcc $(CFLAGS) $(LDFLAGS) $(OBJ) -o $@

obj/obj-stamp:
	mkdir -p obj
	touch $@

obj/%.o: src/%.c
	gcc $(CFLAGS) -c $< -o $@

clean:
	rm -fr obj $(TARGET)

open_project:
	screen -t vim vim Makefile src/*

.PHONY: all clean open_project