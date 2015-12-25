/* Item.vala
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
	public abstract class Item : Object {
		public int x {protected set; get;}
		public int y {protected set; get;}
		public int size {protected set; get;}

		public abstract void draw (Cairo.Context cr);
		public virtual bool is_match (Item item) {
			if (x == item.x && y == item.y) {
				return true;
			} else {
				return false;
			}
		}
	}
}
