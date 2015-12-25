namespace Snake {
	public class Board : Gtk.DrawingArea {
		private Snake snake;
		private Walls walls;
		private FoodCreator food_creator;
		private Point food;

		public bool is_game {set; get; default = true;}
		public bool grid_on {set; get; default = true;}

		public Board (int width, int height) {
			width_request = width;
			height_request = height;
			expand = true;
			halign = Gtk.Align.CENTER;
			valign = Gtk.Align.CENTER;

			snake = new Snake (4, Direction.RIGHT);
			walls = new Walls (width, height);
			food_creator = new FoodCreator (width, height);
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
			// Draw snake
			snake.draw (cr);
			// Draw food
			if (snake.eat_food (food)) {
				food = food_creator.create ();
			}
			food.draw (cr);
			if (is_game) {
				// Make it moves FIXME redraw only snake
				snake.move ();
				Thread.usleep (150000);
				this.queue_draw ();
				// Check hits
				if (snake.is_bite_itself () || walls.is_hit (snake.get_head ())) {
					is_game = false;
				}
			} else {
				cr.save ();
				cr.set_source_rgb (0.1, 0.1, 0.1);
				cr.select_font_face ("Adventure", Cairo.FontSlant.NORMAL, Cairo.FontWeight.BOLD);
				cr.set_font_size (50);
				cr.move_to (100, 250);
				cr.show_text ("Game over");
				cr.move_to (100, 300);
				cr.show_text (@"Score is $(snake.score)");
				cr.restore ();
			}
		}
		private void draw_grid (Cairo.Context cr) {
			cr.save ();
			cr.set_source_rgba (0.7, 0.7, 0.7, 0.5);
			cr.set_line_width (1);
			cr.set_dash ({2,1}, 0);
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
