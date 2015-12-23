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

			var p1 = new Point (10, 30, '*');
			var p2 = new Point (40, 50, '#');
			var top_line = new HorizontalLine (50, 500, 50, '+');
			var right_line = new VerticalLine (500, 50, 500, '+');
			var bottom_line = new HorizontalLine (50, 500, 500, '+');
			var left_line = new VerticalLine (50, 50, 500, '+');

			var main_scene = new Gtk.DrawingArea ();
			main_scene.expand = true;
			main_scene.draw.connect((cr) => {
				p1.draw (cr);
				p2.draw (cr);
				top_line.draw (cr);
				right_line.draw (cr);
				bottom_line.draw (cr);
				left_line.draw (cr);
				return true;
			});

			window.add (main_scene);
			window.show_all ();
		}
		public static int main(string[] args) {
			var app = new Snake.Application ();
			return app.run(args);
		}
	}
}
