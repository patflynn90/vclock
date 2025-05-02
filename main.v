module main

import clock

fn main() {
	mut c := clock.new('HH:mm', true)
	c.run()
}
