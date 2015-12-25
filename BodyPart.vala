/* BodyPart.vala
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
	public class BodyPart : Item {
		private int padding {set; get; default = 1;}

		public bool is_eaten {set; get; default = false;}

		public BodyPart (int x, int y, int size) {
			this.x = x;
			this.y = y;
			this.size = size;
		}
		public BodyPart.copy (BodyPart part) {
			x = part.x;
			y = part.y;
			this.size = part.size;
		}
		public override void draw (Cairo.Context cr) {
			cr.save ();
			if (is_eaten) {
				cr.set_source_rgb (0.1, 0.5, 0.9);
			} else {
				cr.set_source_rgb (0.1, 0.1, 0.1);
			}
			cr.rectangle (x - 0.5*size + padding, y - 0.5*size + padding, size - 2*padding, size - 2*padding);
			cr.fill ();
			cr.restore ();
		}
		public void move (int offset, Direction dir) {
			int k = size;
			if (dir == Direction.LEFT || dir == Direction.UP) {
				k *= -1;
			}
			switch (dir) {
				case Direction.RIGHT:
				case Direction.LEFT:
					x += k*offset;
					break;
				case Direction.UP:
				case Direction.DOWN:
					y += k*offset;
					break;
			}
		}
	}
}
