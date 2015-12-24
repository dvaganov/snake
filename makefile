SRC = \
Application.vala \
Board.vala \
Point.vala \
HorizontalLine.vala \
VerticalLine.vala \
Figure.vala \
Snake.vala \
Direction.vala \
FoodCreator.vala \
Walls.vala

PKG = --pkg gtk+-3.0
all: snake

snake: $(SRC)
	valac $(PKG) -o snake $(SRC)
