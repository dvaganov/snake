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

			var game_board = new Board (500, 500);

			window.key_press_event.connect ((key) => {
				game_board.key_handle (key);
				return false;
			});

			window.add (game_board);
			window.show_all ();
		}
		public static int main(string[] args) {
			var app = new Application ();
			return app.run(args);
		}
	}
}
