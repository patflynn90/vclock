module main

import os
import clock
import termctl

fn main() {
	center := '--center' in os.args
	mut c := clock.new('hh:mmA', true)

	mut ts := termctl.TermState{}
	ts.enable()
	defer { ts.disable() }

	c.run(center)
}
