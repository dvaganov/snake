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
	public enum Speed {
		LOW = 100,
		MEDIUM = 75,
		HIGH = 50;
		public string to_string () {
			switch (this) {
				case LOW: return "Low";
				case MEDIUM: return "Medium";
				case HIGH: return "High";
				default: return "Unkonwn";
			}
		}
	}
	public class Board : Gtk.DrawingArea {
		private Snake snake;
		private Walls walls;
		private FoodCreator food_creator;
		private Point food;
		private bool _has_grid;
		private bool _has_walls;
		private bool _in_game;
		private int score;
		private uint32 last_key_time;

		public bool has_grid {
			get {return _has_grid;}
			set {_has_grid = value; queue_draw ();}
		}
		public bool has_walls {
			get {return _has_walls;}
			set {_has_walls = value; queue_draw ();}
		}
		public Speed speed {get; set; default = Speed.LOW;}

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
			_in_game = false;
			_has_grid = true;
			_has_walls = true;

			this.draw.connect((cr) => {
				draw_in_context (cr);
				return true;
			});
		}
		private void draw_in_context (Cairo.Context cr) {
			// Draw grid
			if (has_grid) {
				draw_grid (cr);
			}
			// Draw border
			if (has_walls) {
				walls.draw (cr);
			}
			if (_in_game) {
				// Draw snake
				snake.draw (cr);
				// Draw food
				if (snake.eat_food (food)) {
					food = food_creator.create ();
					score++;
					on_score_change (score);
				}
				food.draw (cr);
				// Check hits
				if (snake.is_bite_itself ()) {
					_in_game = false;
				} else if (has_walls && walls.is_hit (snake.get_head ())) {
					_in_game = false;
				}
				Thread.usleep (speed*1000);
				// Make it moves FIXME redraw only snake
				snake.move ();
				queue_draw ();
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
			snake = new Snake (4, width_request, height_request);
			food = food_creator.create ();
			score = 0;
			on_score_change (score);
			_in_game = true;
			queue_draw ();
		}
	}
}

