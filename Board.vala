namespace Snake {
	public class Board : Gtk.DrawingArea {
		private Snake snake;
		private Walls walls;
		private FoodCreator food_creator;
		private Point food;

		public bool grid_on {set; get; default = true;}

		public Board (double width, double height) {
			width_request = (int) width;
			height_request = (int) height;
			expand = true;
			halign = Gtk.Align.CENTER;
			valign = Gtk.Align.CENTER;

			snake = new Snake (new Point (40, 50, '*'), 4, Direction.RIGHT);
			walls = new Walls (width, height);
			food_creator = new FoodCreator (width, height, '$');

			food = food_creator.create ();

			this.draw.connect((cr) => {
				draw_in_context (cr);
				return true;
			});
		}
		private void draw_in_context (Cairo.Context cr) {
				// Draw grid
				if (grid_on) {
					draw_grid (cr);
				}
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
		private void draw_grid (Cairo.Context cr) {
			cr.save ();
			cr.set_source_rgba (0.7, 0.7, 0.7, 0.5);
			cr.set_line_width (1);
			// Vertical grid
			for (var i = 0; i < width_request / 10; i++) {
				cr.move_to (10*i, 0);
				cr.line_to (10*i, height_request);
			}
			// Horizontal grid
			for (var i = 0; i < height_request / 10; i++) {
				cr.move_to (0, 10*i);
				cr.line_to (width_request, 10*i);
			}
			cr.stroke ();
			cr.restore ();
		}
		public void key_handle (Gdk.EventKey key) {
			snake.key_handle (key);
			queue_draw ();
		}
	}
}
