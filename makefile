all: snake.vala point.vala HorizontalLine.vala VerticalLine.vala Figure.vala
	valac --pkg gtk+-3.0 snake.vala point.vala HorizontalLine.vala VerticalLine.vala Figure.vala
