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
		public void key_handle (Gdk.EventKey key) {
			Direction direction_new;
			switch (key.keyval) {
				case Gdk.Key.Right:
					direction_new = Direction.RIGHT;
					break;
				case Gdk.Key.Left:
					direction_new = Direction.LEFT;
					break;
				case Gdk.Key.Up:
					direction_new = Direction.UP;
					break;
				case Gdk.Key.Down:
					direction_new = Direction.DOWN;
					break;
				default:
					direction_new = direction;
					break;
			}
			if (direction == Direction.LEFT && direction_new != Direction.RIGHT) {
				direction = direction_new;
			} else if (direction == Direction.RIGHT && direction_new != Direction.LEFT) {
				direction = direction_new;
			} else if (direction == Direction.UP && direction_new != Direction.DOWN) {
				direction = direction_new;
			} else if (direction == Direction.DOWN && direction_new != Direction.UP) {
				direction = direction_new;
			}
		}
	}
}
