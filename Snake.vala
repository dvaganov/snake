namespace Snake {
	public class Snake : Object {
		private Direction direction;
		private GenericArray<BodyPart?> body;

		public Snake (int length, Direction _direction) {
			direction = _direction;
			body = new GenericArray<BodyPart?> ();
			// Create tail
			var part = new BodyPart (50, 50, 10);
			body.add (part);
			// Create body
			for (var i = 0; i < length; i++) {
				part = new BodyPart.copy (body[0]);
				part.move (i, direction);
				body.add (part);
			}
		}
		public void draw (Cairo.Context cr) {
			for (var i = 0; i < body.length; i++) {
				body[i].draw (cr);
			}
		}
		public void move () {
			body.remove_index (0);
			var head = new BodyPart.copy (body[body.length - 1]);
			head.move (1, direction);
			body.add (head);
		}
		/*public bool eat_food (Point food) {
			bool is_eaten;
			var head = p_list[p_list.length - 1];
			var tail = p_list[0];
			if (head.is_match (food)) {
				food.symb = tail.symb;
				food.x = tail.x;
				food.y = tail.y;
				food.move (-1, direction);
				p_list.insert (0, food);
				is_eaten = true;
			} else {
				is_eaten = false;
			}
			return is_eaten;
		}
		public bool is_hit_fig (Figure fig) {
			bool is_hit;
			var head = p_list[p_list.length - 1];
			if (fig.is_hit_point (head)) {
				is_hit = true;
			} else {
				is_hit = false;
			}
			return is_hit;
		}*/
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
