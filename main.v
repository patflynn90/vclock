module main

import clock
import termctl
import cli

fn main() {
	cfg := cli.parse_args()
	mut c := clock.new(cfg)

	mut ts := termctl.TermState{}
	ts.enable_input_hiding()
	defer { ts.disable_input_hiding() }

	c.run()
}
