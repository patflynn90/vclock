module clock

import arrays
import term
import time
import ascii
import util

pub struct Clock {
	// format is V time custom_format string
	// see https://modules.vlang.io/time.html#Time.custom_format
	format   string
	seconds  bool
	blink    bool
	interval time.Duration
	centered bool
	color    string
	date     bool
mut:
	blink_state bool
}

pub fn new(seconds bool, color string, centered bool, date bool, blink bool) Clock {
	interval := if blink { 500 * time.millisecond } else { 1 * time.second }
	format := if seconds { 'hh:mm:ssA' } else { 'hh:mmA' }
	return Clock{
		format:      format
		seconds:     seconds
		blink:       blink
		interval:    interval
		blink_state: true
		centered:    centered
		color:       color
		date:        date
	}
}

pub fn (mut c Clock) tick() []string {
	now := time.now()
	mut timestr := now.custom_format(c.format)
	mut datestr := if c.date { [now.custom_format('dddd MMMM Do, YYYY')] } else { [] }

	if c.blink && !c.blink_state {
		timestr = timestr.replace(':', ' ')
	}

	c.blink_state = !c.blink_state

	mut time_art := ascii.render_string(timestr)
	return if c.date { arrays.append(time_art, datestr) } else { time_art }
}

pub fn (mut c Clock) run() {
	for {
		util.clear_screen()
		util.move_cursor_home()

		clock_lines := c.tick()
		term_width, term_height := term.get_terminal_size()

		clock_height := clock_lines.len

		vert_pad := if c.centered && term_height > clock_height {
			(term_height - clock_height) / 2
		} else {
			0
		}

		for _ in 0 .. vert_pad {
			println('')
		}

		for line in clock_lines {
			padded_line := if c.centered { util.pad_line_to_center(line, term_width) } else { line }
			util.print_colored_line(c.color, '${padded_line}')
		}

		time.sleep(c.interval)
	}
}
