module clock

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

pub fn (mut c Clock) run() {
	for {
		util.clear_screen()
		util.move_cursor_home()
		for line in c.tick() {
			println(line)
		}
		time.sleep(c.interval)
	}
}
