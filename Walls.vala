namespace Snake {
	public class Walls : Object {
		private double map_width;
		private double map_height;

		public int border_width {set; get; default = 5;}

		public Walls (double map_width, double map_height) {
			this.map_width = map_width;
			this.map_height = map_height;
		}
		public void draw (Cairo.Context cr) {
			cr.save ();
			cr.set_source_rgb (0.1, 0.1, 0.1);
			cr.set_line_width (border_width);
			cr.rectangle (0, 0, map_width, map_height);
			cr.stroke ();
			cr.restore ();
		}
	}
}
