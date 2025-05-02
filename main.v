module main

import clock

fn main() {
	mut c := clock.new('hh:mmA', true)
	c.run()
}
