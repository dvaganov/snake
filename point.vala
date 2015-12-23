namespace Snake {
	public class Point : Object {
		public double x {set; get;}
		public double y {set; get;}
		public char symb {set; get;}

		public Point () {

		}
		public void draw (Cairo.Context cr) {
			cr.save ();
			cr.set_source_rgb (0.1, 0.1, 0.1);
			cr.select_font_face ("Adventure", Cairo.FontSlant.NORMAL, Cairo.FontWeight.BOLD);
			cr.set_font_size (20);
			cr.move_to (x, y);
			cr.show_text (symb.to_string());
			cr.restore ();
		}
	}
}
