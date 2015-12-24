namespace Snake {
	public class Snake : Figure {
		public Snake (Point tail, int length, Direction dir) {
			p_list = new GenericArray<Point?> ();
			for (var i = 0; i < length; i++) {
				var p = new Point.copy (tail);
				p.move (i, dir);
				p_list.add (p);
			}
		}
	}
}
