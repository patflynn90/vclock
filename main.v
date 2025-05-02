module main

import flag
import os
import clock
import termctl

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fc := flag.FlagConfig{}
	clock_color := fp.string('color', `c`, 'none', '', fc)
	clock_centering := fp.bool('nocenter', 0, false, '', fc)
	clock_date := fp.bool('nodate', `d`, false, '', fc)
	clock_blink := fp.bool('noblink', `b`, false, '', fc)

	clock_format := 'hh:mmA'

	mut c := clock.new(clock_format, // clock format
	 clock_color, // color of clock display (if any)
	 !clock_centering, // should output be centered in terminal
	 !clock_date, // should date be displayed
	 !clock_blink // should the clock clock blink
	 )

	mut ts := termctl.TermState{}
	ts.enable_input_hiding()
	defer { ts.disable_input_hiding() }

	c.run()
}
