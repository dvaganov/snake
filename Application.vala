/* Application.vala
 *
 * Copyright (C) 2015 Dmitrii Vaganov <d.vaganov92@yandex.ru>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Snake {
	public class Application : Gtk.Application {
		public Application() {
			Object(application_id: "snake.game",
				flags: ApplicationFlags.FLAGS_NONE);
		}
		protected override void activate () {
			var window = new Gtk.ApplicationWindow (this);
			window.title = "Snake";

			var header_bar = new Gtk.HeaderBar ();
			header_bar.show_close_button = true;
			header_bar.title = "Snake";
			window.set_titlebar (header_bar);

			var menu_btn = new Gtk.MenuButton ();
			header_bar.pack_end (menu_btn);

			var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

			var game_board = new Board (400, 300);
			game_board.on_score_change.connect ((score) => {
				header_bar.subtitle = @"Score is $score";
			});
			//popover.add (game_board.settings ());
			box.pack_start (game_board);

			var btn = new Gtk.Button.with_label ("Start game");
			btn.clicked.connect (() => {
				game_board.start ();
			});
			header_bar.pack_start (btn);

			window.add (box);
			window.key_press_event.connect ((key) => {
				game_board.key_handle (key);
				return false;
			});
			window.show_all ();

			var prop_action = new PropertyAction ("has-grid", game_board, "has-grid");
			window.add_action (prop_action);
			prop_action = new PropertyAction ("has-walls", game_board, "has-walls");
			window.add_action (prop_action);

			var menu = new Menu ();
			menu.append ("Grid", "win.has-grid");
			menu.append ("Walls", "win.has-walls");
			menu_btn.menu_model = menu;
		}
		public static int main(string[] args) {
			var app = new Application ();
			return app.run(args);
		}
	}
}
