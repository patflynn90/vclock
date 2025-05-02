module main

import os
import clock

fn main() {
	center := '--center' in os.args
	mut c := clock.new('hh:mmA', true)
	c.run(center)
}
