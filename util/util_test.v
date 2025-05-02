module util

import os

const vexe = @VEXE

fn write_tmp(path string, code string) {
	os.write_file(path, code) or { panic(err) }
}

fn test_clear_screen_sequence() {
	path := 'util_clear.v'
	snippet := '
import util
fn main() {
	util.clear_screen()
}
'
	write_tmp(path, snippet)
	defer {
		os.rm(path) or {}
	}
	res := os.execute('"${vexe}" run util_clear.v')
	assert res.exit_code == 0
	assert res.output == '\x1b[2J'
}

fn test_move_cursor_home_sequence() {
	path := 'util_home.v'
	snippet := '
import util
fn main() {
	util.move_cursor_home()
}
'
	write_tmp(path, snippet)
	defer {
		os.rm(path) or {}
	}
	res := os.execute('"${vexe}" run util_home.v')
	assert res.exit_code == 0
	assert res.output == '\x1b[H'
}
