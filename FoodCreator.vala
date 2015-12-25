namespace Snake {
	public class FoodCreator : Object {
		int map_width;
		int map_height;

		public FoodCreator (int map_width, int map_height) {
			this.map_width = map_width;
			this.map_height = map_height;
		}
		public Point create () {
			int x = Random.int_range (10, (map_width - 10));
			x /= 10;
			int y = Random.int_range (10, (map_height - 10));
			y /= 10;
			var food = new Point (x*10, y*10, 10);
			return food;
		}
	}
}
