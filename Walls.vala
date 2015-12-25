/* Walls.vala
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
	public class Walls : Object {
		private int map_width;
		private int map_height;

		public int border_width {set; get; default = 5;}

		public Walls (int map_width, int map_height) {
			this.map_width = map_width;
			this.map_height = map_height;
		}
		public void draw (Cairo.Context cr) {
			cr.save ();
			cr.set_source_rgb (0.1, 0.1, 0.1);
			cr.set_line_width (border_width);
			cr.rectangle (0, 0, map_width, map_height);
			cr.stroke ();
			cr.restore ();
		}
		public bool is_hit (Item item) {
			if (item.x == 0 || item.x == map_width) {
				return true;
			}
			if (item.y == 0 || item.y == map_height) {
				return true;
			}
			return false;
		}
	}
}
