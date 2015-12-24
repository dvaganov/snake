namespace Snake {
	public class Snake : Figure {
		private Direction direction;

		public Snake (Point tail, int length, Direction _direction) {
			direction = _direction;
			p_list = new GenericArray<Point?> ();
			for (var i = 0; i < length; i++) {
				var p = new Point.copy (tail);
				p.move (i, direction);
				p_list.add (p);
			}
		}
		public void move () {
			p_list.remove_index (0);
			var head = new Point.copy (p_list[p_list.length - 1]);
			head.move (1, direction);
			p_list.add (head);
		}
	}
}
