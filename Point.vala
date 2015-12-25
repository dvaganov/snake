namespace Snake {
	public class Point : Item {
		public Point (int x, int y, int size) {
			this.x = x;
			this.y = y;
			this.size = size;
		}
		public override void draw (Cairo.Context cr) {
			cr.save ();
			cr.set_source_rgb (0.1, 0.1, 0.1);
			cr.arc (x, y, 0.5*size, 0, 2*Math.PI);
			cr.fill ();
			cr.restore ();
		}
	}
}
