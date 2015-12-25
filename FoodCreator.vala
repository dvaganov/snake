/* FoodCreator.vala
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
	public class FoodCreator : Object {
		int map_width;
		int map_height;

		public FoodCreator (int map_width, int map_height) {
			this.map_width = map_width;
			this.map_height = map_height;
		}
		public Point create () {
			int x = Random.int_range (10, (map_width - 10));
			x /= 10;
			int y = Random.int_range (10, (map_height - 10));
			y /= 10;
			var food = new Point (x*10, y*10, 10);
			return food;
		}
	}
}
