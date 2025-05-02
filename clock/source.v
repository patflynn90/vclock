module clock

import term
import time
import ascii
import util

pub struct Clock {
	// format is V time custom_format string
	// see https://modules.vlang.io/time.html#Time.custom_format
	format   string
	blink    bool
	interval time.Duration
mut:
	blink_state bool
}

pub fn new(format string, blink bool) Clock {
	interval := if blink { 500 * time.millisecond } else { 1 * time.second }
	return Clock{
		format:      format
		blink:       blink
		interval:    interval
		blink_state: true
	}
}

pub fn (mut c Clock) tick() []string {
	now := time.now()
	mut timestr := now.custom_format(c.format)

	if c.blink && !c.blink_state {
		timestr = timestr.replace(':', ' ')
	}

	c.blink_state = !c.blink_state

	return ascii.render_string(timestr)
}

pub fn (mut c Clock) run(center bool, color string) {
	for {
		util.clear_screen()
		util.move_cursor_home()

		clock_lines := c.tick()
		term_width, term_height := term.get_terminal_size()

		clock_height := clock_lines.len

		vert_pad := if center && term_height > clock_height {
			(term_height - clock_height) / 2
		} else {
			0
		}

		for _ in 0 .. vert_pad {
			println('')
		}

		for line in clock_lines {
			padded_line := if center { util.pad_line_to_center(line, term_width) } else { line }
			util.print_colored_line(color, '${padded_line}')
		}

		time.sleep(c.interval)
	}
}
