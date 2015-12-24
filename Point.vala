namespace Snake {
	public class Point : Object {
		public double x;
		public double y;
		public char symb;

		public Point (double _x, double _y, char _symb) {
			x = _x;
			y = _y;
			symb = _symb;
		}
		public Point.copy (Point p) {
			x = p.x;
			y = p.y;
			symb = p.symb;
		}
		public void draw (Cairo.Context cr) {
			cr.save ();
			cr.set_source_rgb (0.1, 0.1, 0.1);
			cr.select_font_face ("Adventure", Cairo.FontSlant.NORMAL, Cairo.FontWeight.BOLD);
			cr.set_font_size (15);
			cr.move_to (x, y);
			cr.show_text (symb.to_string());
			cr.restore ();
		}
		public void move (int offset, Direction dir) {
			offset *= 10;
			switch (dir) {
				case Direction.RIGHT:
					x += offset;
					break;
				case Direction.LEFT:
					x -= offset;
					break;
				case Direction.UP:
					y -= offset;
					break;
				case Direction.DOWN:
					y += offset;
					break;
			}
		}
	}
}
