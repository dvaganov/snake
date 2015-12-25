SRC = \
Application.vala \
Board.vala \
BodyPart.vala \
Snake.vala \
Direction.vala \
Walls.vala \
Item.vala \
FoodCreator.vala \
Point.vala

PKG = --pkg gtk+-3.0
all: snake

snake: $(SRC)
	valac $(PKG) -o snake $(SRC)
