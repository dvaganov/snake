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
