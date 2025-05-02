module clock

import time
import ascii

fn test_new_initial_states() {
	c1 := new('HH:mm', true)
	assert c1.format == 'HH:mm'
	assert c1.blink == true
	assert c1.interval == 500 * time.millisecond
	assert c1.blink_state == true

	c2 := new('HH:mm', false)
	assert c2.blink == false
	assert c2.interval == 1 * time.second
	assert c2.blink_state == true
}

fn test_tick_basic_behavior() {
	mut c := new('HH:mm', true)
	assert c.blink_state == true
	lines := c.tick()
	assert lines.len == 5
	assert c.blink_state == false

	_ = c.tick()
	assert c.blink_state == true
}

fn test_blink_replaces_colon() {
	mut c := new(':', true)

	colon_out := c.tick()
	space_out := c.tick()

	expected_colon := ascii.render_string(':')
	expected_space := ascii.render_string(' ')

	assert colon_out == expected_colon
	assert space_out == expected_space
}
