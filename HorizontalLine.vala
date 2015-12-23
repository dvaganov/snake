namespace Snake {
	public class HorizontalLine : Figure {
		public HorizontalLine (double x_start, double x_end, double y, char symb) {
			p_list = new GenericArray<Point?> ();
			for (var x = x_start; x <= x_end; x += 10) {
				var p = new Point (x, y, symb);
				p_list.add (p);
			}
		}
	}
}
