namespace Snake {
	public class Figure : Object {
		protected GenericArray<Point?> p_list;

		public void draw (Cairo.Context cr) {
			for (var i = 0; i < p_list.length; i++) {
				p_list[i].draw (cr);
			}
		}
	}
}
