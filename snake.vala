namespace Snake {
	public class Application : Gtk.Application {
		public Application() {
			Object(application_id: "snake.game",
				flags: ApplicationFlags.FLAGS_NONE);
		}
		protected override void activate () {
			var window = new Gtk.ApplicationWindow (this);
			window.set_default_size (400, 400);
			window.title = "Snake";

			var p1 = new Point (10, 30, '*');
			var p2 = new Point (40, 50, '#');

			var main_scene = new Gtk.DrawingArea ();
			main_scene.expand = true;
			main_scene.draw.connect((cr) => {
				p1.draw (cr);
				p2.draw (cr);
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
