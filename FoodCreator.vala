namespace Snake {
	public class FoodCreator : Object {
		char symb;
		double map_width;
		double map_height;

		public FoodCreator (double map_width, double map_height, char symb) {
			this.map_width = map_width;
			this.map_height = map_height;
			this.symb = symb;
		}
		public Point create () {
			int x = Random.int_range (10, (int) (map_width - 10));
			x /= 10;
			int y = Random.int_range (10, (int) (map_height - 10));
			y /= 10;
			var food = new Point (x*10, y*10, symb);
			return food;
		}
	}
}
