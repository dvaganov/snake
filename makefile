SRC = \
Application.vala \
Point.vala \
HorizontalLine.vala \
VerticalLine.vala \
Figure.vala

PKG = --pkg gtk+-3.0
all: snake

snake: $(SRC)
	valac $(PKG) -o snake $(SRC)
