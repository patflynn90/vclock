module main

import flag
import os
import clock
import termctl

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fc := flag.FlagConfig{}
	centered_output := fp.bool('center', 0, false, '', fc)
	output_color := fp.string('color', `c`, 'none', '', fc)

	mut c := clock.new('hh:mmA', true)

	mut ts := termctl.TermState{}
	ts.enable()
	defer { ts.disable() }

	c.run(centered_output, output_color)
}
