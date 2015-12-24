namespace Snake {
	public class Board : Gtk.DrawingArea {
		private Snake snake;
		private Walls walls;
		private FoodCreator food_creator;
		private Point food;

		public Board (double width, double height) {
			snake = new Snake (new Point (40, 50, '*'), 4, Direction.RIGHT);
			walls = new Walls (width, height);
			food_creator = new FoodCreator (width, height, '$');

			food = food_creator.create ();

			this.expand = true;
			this.draw.connect((cr) => {
				cr.translate (0.5*(get_allocated_width () - width), 0.5*(get_allocated_height () - height));
				draw_in_context (cr);
				return true;
			});
		}
		private void draw_in_context (Cairo.Context cr) {
				// Draw border
				walls.draw (cr);
				// Draw food
				if (snake.eat_food (food)) {
					food = food_creator.create ();
				}
				food.draw (cr);
				// Draw snake
				snake.draw (cr);
				// Make it moves FIXME redraw only snake
				snake.move ();
				Thread.usleep (100000);
				this.queue_draw ();
				// Check hits
				if (snake.is_hit_fig (snake)) {
					print ("game over\n");
				}
		}
		public void key_handle (Gdk.EventKey key) {
			snake.key_handle (key);
			queue_draw ();
		}
	}
}
