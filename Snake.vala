/* Snake.vala
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
	public class Snake : Object {
		private Direction direction;
		private GenericArray<BodyPart?> body;
		private int initial_length;
		private int map_width;
		private int map_height;

		public int score {get {return body.length - initial_length;}}

		public Snake (int length, int map_width, int map_height) {
			initial_length = length;
			this.map_width = map_width;
			this.map_height = map_height;

			direction = Direction.RIGHT;
			body = new GenericArray<BodyPart?> ();
			// Create tail
			var part = new BodyPart (50, 50, 10);
			body.add (part);
			// Create body
			for (var i = 0; i < initial_length; i++) {
				part = new BodyPart.copy (body[0]);
				part.move (i, direction);
				body.add (part);
			}
		}
		public inline BodyPart get_head () {return body[body.length - 1];}
		public void draw (Cairo.Context cr) {
			get_head ().is_head = true;
			body[body.length - 2].is_head = false;
			for (var i = 0; i < body.length; i++) {
				body[i].draw (cr);
			}
		}
		public void move () {
			body.remove_index (0);
			var head = new BodyPart.copy (get_head ());
			if (head.cross_hline (0, map_width, 0)) {
				head.move (1, direction, map_height);
			} else if (head.cross_hline (0, map_width, map_height)) {
				head.move (1, direction, 0);
			} else if (head.cross_vline (0, 0, map_height)) {
				head.move (1, direction, map_width);
			} else if (head.cross_vline (map_width, 0, map_height)) {
				head.move (1, direction, 0);
			} else {
				head.move (1, direction);
			}
			head.is_head = true;
			body.add (head);
		}
		public bool eat_food (Item food) {
			var tail = body[0];
			if (get_head ().is_match (food)) {
				get_head ().is_eaten = true;
				var new_tail = new BodyPart.copy (tail);
				new_tail.move (-1, direction);
				body.insert (0, new_tail);
				return true;
			} else {
				return false;
			}
		}
		public bool is_bite_itself () {
			var head = get_head ();
			for (var i = 0; i < body.length - 1; i++) { //Excluding head itself
				if (head.is_match (body[i])) {
					return true;
				}
			}
			return false;
		}
		public void key_handle (Gdk.EventKey key) {
			Direction direction_new;
			switch (key.keyval) {
				case Gdk.Key.Right:
					direction_new = Direction.RIGHT;
					break;
				case Gdk.Key.Left:
					direction_new = Direction.LEFT;
					break;
				case Gdk.Key.Up:
					direction_new = Direction.UP;
					break;
				case Gdk.Key.Down:
					direction_new = Direction.DOWN;
					break;
				default:
					direction_new = direction;
					break;
			}
			if (direction == Direction.LEFT && direction_new != Direction.RIGHT) {
				direction = direction_new;
			} else if (direction == Direction.RIGHT && direction_new != Direction.LEFT) {
				direction = direction_new;
			} else if (direction == Direction.UP && direction_new != Direction.DOWN) {
				direction = direction_new;
			} else if (direction == Direction.DOWN && direction_new != Direction.UP) {
				direction = direction_new;
			}
		}
	}
}
