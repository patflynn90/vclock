module util

import term

// ANSI escape to clear screen
pub fn clear_screen() {
	print('\x1b[2J')
}

// ANSI escape to move cursor top-left
pub fn move_cursor_home() {
	print('\x1b[H')
}

pub fn print_colored_line(color string, line string) {
	colored_line := match color {
		'blue' { term.colorize(term.blue, line) }
		'cyan' { term.colorize(term.cyan, line) }
		'green' { term.colorize(term.green, line) }
		'magenta' { term.colorize(term.magenta, line) }
		'red' { term.colorize(term.red, line) }
		'yellow' { term.colorize(term.yellow, line) }
		else { line }
	}
	println(colored_line)
}

pub fn pad_line_to_center(line string, width int) string {
	line_length := line.runes().len
	if width < line_length {
		return line
	}

	padding := (width - line_length) / 2
	pad_spaces := ' '.repeat(padding)
	return '${pad_spaces}${line}'
}
