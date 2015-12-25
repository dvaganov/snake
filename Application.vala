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

			var header_bar = new Gtk.HeaderBar ();
			header_bar.show_close_button = true;
			header_bar.title = "Snake";
			window.set_titlebar (header_bar);

			var menu_btn = new Gtk.MenuButton ();
			header_bar.pack_end (menu_btn);

			var popover = new Gtk.Popover (menu_btn);
			menu_btn.set_popover (popover);

			var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

			//var results = new Gtk.Label ("");
			//box.pack_start (results, false, false);

			var game_board = new Board (400, 300);
			game_board.on_score_change.connect ((score) => {
				header_bar.subtitle = @"Score is $score";
			});
			popover.add (game_board.settings ());
			box.pack_start (game_board);

			var btn = new Gtk.Button.with_label ("Start game");
			btn.clicked.connect (() => {
				game_board.start ();
			});
			box.pack_start (btn, false, false);

			window.add (box);
			window.key_press_event.connect ((key) => {
				game_board.key_handle (key);
				return false;
			});
			window.show_all ();
		}
		public static int main(string[] args) {
			var app = new Application ();
			return app.run(args);
		}
	}
}
