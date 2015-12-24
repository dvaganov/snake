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

			var p1 = new Point (40, 50, '*');
			var snake = new Snake (p1, 4, Direction.RIGHT);
			var top_line = new HorizontalLine (10, 500, 10, '+');
			var right_line = new VerticalLine (500, 10, 500, '+');
			var bottom_line = new HorizontalLine (10, 500, 500, '+');
			var left_line = new VerticalLine (10, 10, 500, '+');

			var main_scene = new Gtk.DrawingArea ();
			main_scene.expand = true;
			main_scene.draw.connect((cr) => {
				top_line.draw (cr);
				right_line.draw (cr);
				bottom_line.draw (cr);
				left_line.draw (cr);
				snake.draw (cr);
				return true;
			});

			var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
			box.pack_start (main_scene);

			var button = new Gtk.Button.with_label ("Move!");
			button.clicked.connect (() => {
				snake.move ();
				main_scene.queue_draw ();
			});
			box.pack_start (button, false, false);

			window.add (box);
			window.show_all ();
		}
		public static int main(string[] args) {
			var app = new Application ();
			return app.run(args);
		}
	}
}
