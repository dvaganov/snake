namespace Snake {
	public class Application : Gtk.Application {
		public Application() {
			Object(application_id: "snake.game",
				flags: ApplicationFlags.FLAGS_NONE);
		}
		protected override void activate () {
			var window = new Gtk.ApplicationWindow (this);
			window.set_default_size (550, 550);
			window.title = "Snake";

			var top_line = new HorizontalLine (10, 500, 10, '+');
			var right_line = new VerticalLine (500, 10, 500, '+');
			var bottom_line = new HorizontalLine (10, 500, 500, '+');
			var left_line = new VerticalLine (10, 10, 500, '+');

			var tail = new Point (40, 50, '*');
			var snake = new Snake (tail, 4, Direction.RIGHT);

			var food_creator = new FoodCreator (550, 550, '$');
			var food = food_creator.create ();

			var main_scene = new Gtk.DrawingArea ();
			main_scene.expand = true;
			main_scene.set_events (Gdk.EventMask.KEY_PRESS_MASK);
			main_scene.draw.connect((cr) => {
				// Draw border
				top_line.draw (cr);
				right_line.draw (cr);
				bottom_line.draw (cr);
				left_line.draw (cr);
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
				main_scene.queue_draw ();
				return true;
			});
			window.key_press_event.connect ((key) => {
				snake.key_handle (key);
				main_scene.queue_draw ();
				return false;
			});

			window.add (main_scene);
			window.show_all ();
		}
		public static int main(string[] args) {
			var app = new Application ();
			return app.run(args);
		}
	}
}
