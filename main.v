module main

import ascii

fn main() {
	for line in ascii.render_string('12:34') {
		println(line)
	}
}
