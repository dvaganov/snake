namespace Snake {
	public class Figure : Object {
		protected GenericArray<Point?> p_list;

		public virtual void draw (Cairo.Context cr) {
			for (var i = 0; i < p_list.length; i++) {
				p_list[i].draw (cr);
			}
		}
		public bool is_hit_point (Point p) {
			for (var i = 0; i < p_list.length; i++) {
				if (p.is_match (p_list[0])) {
					return true;
				}
			}
			return false;
		}
	}
}
