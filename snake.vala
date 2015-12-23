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

			var main_scene = new Gtk.DrawingArea ();
			main_scene.expand = true;
			main_scene.draw.connect((cr) => {
				this.draw(cr, 10, 30, "*");
				this.draw(cr, 40, 50, "#");
				return true;
			});

			window.add (main_scene);
			window.show_all ();
		}
		private void draw(Cairo.Context cr, double x, double y, string simb) {
			cr.save();
			cr.set_source_rgb (0.1, 0.1, 0.1);
			cr.select_font_face ("Adventure", Cairo.FontSlant.NORMAL, Cairo.FontWeight.BOLD);
			cr.set_font_size (20);
			cr.move_to(x, y);
			cr.show_text(simb);
			cr.restore();
		}
		public static int main(string[] args) {
			var app = new Snake.Application ();
			return app.run(args);
		}
	}
}
