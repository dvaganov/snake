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

			var p1 = new Point ();
			p1.x = 10;
			p1.y = 30;
			p1.symb = '*';

			var p2 = new Point ();
			p2.x = 40;
			p2.y = 50;
			p2.symb = '#';

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
