module main

import os
import clock
import termctl
import cli

fn main() {
	// parse flags and instantiate clock
	cfg := cli.parse_args()
	mut c := clock.new(cfg)

	// initialize terminal state on the real tty
	mut ts := termctl.TermState{}
	// open /dev/tty for reliable control even if stdin is redirected
	ts.open_tty('/dev/tty') or {
		eprintln('failed to open /dev/tty: ${err}')
		return
	}
	ts.enable_input_hiding()
	defer { ts.disable_input_hiding() }

	// register SIGINT handler
	_ := os.signal_opt(.int, fn [mut ts] (_ os.Signal) {
		ts.disable_input_hiding()
		exit(0)
	}) or {
		eprintln('error: failed to register SIGINT handler: ${err}')
		ts.disable_input_hiding()
		exit(1)
	}

	// register SIGTERM handler
	_ := os.signal_opt(.term, fn [mut ts] (_ os.Signal) {
		ts.disable_input_hiding()
		exit(0)
	}) or {
		eprintln('error: failed to register SIGTERM handler: ${err}')
		ts.disable_input_hiding()
		exit(1)
	}

	c.run()
}
