namespace Snake {
	public class BodyPart : Item {
		private int padding {set; get; default = 1;}

		public bool is_eaten {set; get; default = false;}

		public BodyPart (int x, int y, int size) {
			this.x = x;
			this.y = y;
			this.size = size;
		}
		public BodyPart.copy (BodyPart part) {
			x = part.x;
			y = part.y;
			this.size = part.size;
		}
		public override void draw (Cairo.Context cr) {
			cr.save ();
			if (is_eaten) {
				cr.set_source_rgb (0.1, 0.1, 0.7);
			} else {
				cr.set_source_rgb (0.1, 0.1, 0.1);
			}
			cr.rectangle (x - 0.5*size + padding, y - 0.5*size + padding, size - 2*padding, size - 2*padding);
			cr.fill ();
			cr.restore ();
		}
		public void move (int offset, Direction dir) {
			int k = size;
			if (dir == Direction.LEFT || dir == Direction.UP) {
				k *= -1;
			}
			switch (dir) {
				case Direction.RIGHT:
				case Direction.LEFT:
					x += k*offset;
					break;
				case Direction.UP:
				case Direction.DOWN:
					y += k*offset;
					break;
			}
		}
		/*public bool is_match (Point p) {
			bool is_match;
			if (this.x == p.x && this.y == p.y) {
				is_match = true;
			} else {
				is_match = false;
			}
			return is_match;
		}*/
	}
}
