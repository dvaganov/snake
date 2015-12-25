/* Board.vala
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
	public class Board : Gtk.DrawingArea {
		private const ushort LOW_SPEED = 100;
		private const ushort MEDIUM_SPEED = 50;
		private const ushort HEIGHT_SPEED = 25;
		private Snake snake;
		private Walls walls;
		private FoodCreator food_creator;
		private Point food;
		private bool in_game;
		private int score;
		private ushort speed;
		private uint32 last_key_time;

		public bool grid_on {set; get; default = true;}

		public signal void on_score_change (int score);

		public Board (int width, int height) {
			width_request = width;
			height_request = height;
			margin = 15;
			expand = true;
			halign = Gtk.Align.CENTER;
			valign = Gtk.Align.CENTER;

			walls = new Walls (width, height);
			food_creator = new FoodCreator (width, height);
			in_game = false;
			speed = LOW_SPEED;

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
			if (in_game) {
				// Draw snake
				snake.draw (cr);
				// Draw food
				if (snake.eat_food (food)) {
					food = food_creator.create ();
					score++;
					on_score_change (score);
				}
				food.draw (cr);
				// Make it moves FIXME redraw only snake
				snake.move ();
				queue_draw ();
				// Check hits
				if (snake.is_bite_itself () || walls.is_hit (snake.get_head ())) {
					in_game = false;
				}
				Thread.usleep (speed*1000);
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
			if (snake != null && (key.time - last_key_time) > speed + 0.1*speed) {
				snake.key_handle (key);
				queue_draw ();
			}
			last_key_time = key.time;
		}
		public void start () {
			snake = new Snake (4, Direction.RIGHT);
			food = food_creator.create ();
			score = 0;
			on_score_change (score);
			in_game = true;
			queue_draw ();
		}
		public Gtk.Box settings () {
			var settings_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 5);
			settings_box.margin = 15;

			var label = new Gtk.Label ("Grid");
			label.halign = Gtk.Align.START;
			//label.margin_start = 15;
			settings_box.pack_start (label);

			var @switch = new Gtk.Switch (); // use chekbox
			//@switch.halign = Gtk.Align.END;
			//@switch.margin_end = 15;
			@switch.active = grid_on;
			@switch.notify["active"].connect (() => {
				if (@switch.active) {
					grid_on = true;
				} else {
					grid_on = false;
				}
				queue_draw ();
			});
			settings_box.pack_start (@switch);

			var r_btn1 = new Gtk.RadioButton.with_label (null, "Low speed");
			r_btn1.toggled.connect (() => {
				speed = LOW_SPEED;
			});
			settings_box.pack_start (r_btn1);
			var r_btn2 = new Gtk.RadioButton.with_label_from_widget (r_btn1, "Medium speed");
			r_btn2.toggled.connect (() => {
				speed = MEDIUM_SPEED;
			});
			settings_box.pack_start (r_btn2);
			var r_btn3 = new Gtk.RadioButton.with_label_from_widget (r_btn1, "Height speed");
			r_btn3.toggled.connect (() => {
				speed = HEIGHT_SPEED;
			});
			settings_box.pack_start (r_btn3);

			settings_box.show_all ();

			return settings_box;
		}
	}
}

