namespace Snake {
	public class VerticalLine : Figure {
		public VerticalLine (double x, double y_start, double y_end, char symb) {
			p_list = new GenericArray<Point?> ();
			for (var y = y_start; y <= y_end; y += 10) {
				var p = new Point (x, y, symb);
				p_list.add (p);
			}
		}
	}
}
