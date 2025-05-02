module termctl

import term.termios

pub struct TermState {
mut:
	fd         int
	original   termios.Termios
	is_enabled bool
}

pub fn (mut ts TermState) enable() {
	_ = termios.tcgetattr(ts.fd, mut ts.original)
	mut disabled := ts.original
	disabled.disable_echo()
	termios.set_state(ts.fd, disabled)
	ts.is_enabled = true
}

pub fn (mut ts TermState) disable() {
	termios.set_state(ts.fd, ts.original)
	ts.is_enabled = false
}
