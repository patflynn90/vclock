module util

// ANSI escape to clear screen
pub fn clear_screen() {
	print('\x1b[2J')
}

// ANSI escape to move cursor top-left
pub fn move_cursor_home() {
	print('\x1b[H')
}
