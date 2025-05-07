module termctl

import os
import term.termios

pub struct TermState {
mut:
	fd         int
	original   termios.Termios
	is_enabled bool
}

pub fn (mut ts TermState) open_tty(path string) ? {
	ts.fd = os.open_file(path, 'r+')?.fd
	return
}

pub fn (mut ts TermState) enable_input_hiding() {
	_ = termios.tcgetattr(ts.fd, mut ts.original)
	mut disabled := ts.original
	disabled.disable_echo()
	termios.set_state(ts.fd, disabled)
	// ANSI escape sequence to disable the terminal cursor
	print('\x1b[?25l')
	ts.is_enabled = true
}

pub fn (mut ts TermState) disable_input_hiding() {
	if !ts.is_enabled {
		return
	}
	termios.set_state(ts.fd, ts.original)
	// ANSI escape sequence to display the terminal cursor
	print('\x1b[?25h')
	ts.is_enabled = false
	_ = os.fd_close(ts.fd)
}
