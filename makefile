SRC = \
Application.vala \
Board.vala \
BodyPart.vala \
Snake.vala \
Direction.vala \
Walls.vala \
#Point.vala \
#HorizontalLine.vala \
#VerticalLine.vala \
#Figure.vala \
#FoodCreator.vala \

PKG = --pkg gtk+-3.0
all: snake

snake: $(SRC)
	valac $(PKG) -o snake $(SRC)
