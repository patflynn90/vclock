module clock

import time
import ascii
import cli

fn test_new_initial_states() {
	// blink ON (colon flashes)
	cfg1 := cli.Config{
		blink:        true
		show_seconds: false
	}
	c1 := new(cfg1)
	assert c1.format == 'hh:mmA'
	assert c1.blink == true
	assert c1.interval == 500 * time.millisecond
	assert c1.blink_state == true

	// blink OFF, seconds OFF  → 1-minute interval
	cfg2 := cli.Config{
		blink:        false
		show_seconds: false
	}
	c2 := new(cfg2)
	assert c2.blink == false
	assert c2.interval == 1 * time.minute
	assert c2.blink_state == true

	// seconds ON, blink OFF  → 1-second interval / different format
	cfg3 := cli.Config{
		blink:        false
		show_seconds: true
	}
	c3 := new(cfg3)
	assert c3.format == 'hh:mm:ssA'
	assert c3.interval == 1 * time.second
}

fn test_tick_basic_behavior() {
	mut c := new(cli.Config{ blink: true })
	assert c.blink_state == true
	lines := c.tick()
	assert lines.len == 5 // date disabled in default cfg
	assert c.blink_state == false

	_ = c.tick()
	assert c.blink_state == true
}

fn test_blink_replaces_colon() {
	// Single colon rendered; blink mode toggles it to spaces
	mut c := new(cli.Config{
		blink: true
	})
	c.format = ':'

	colon_out := c.tick() // blink_state toggles to false afterwards
	space_out := c.tick() // produces spaces

	expected_colon := ascii.render_string(':')
	expected_space := ascii.render_string(' ')

	assert colon_out == expected_colon
	assert space_out == expected_space
}

fn test_interval_derivation() {
	assert new(cli.Config{ blink: true }).interval == 500 * time.millisecond
	assert new(cli.Config{ blink: false, show_seconds: true }).interval == 1 * time.second
	assert new(cli.Config{ blink: false, show_seconds: false }).interval == 1 * time.minute
}

fn test_centering_and_color_propagation() {
	cfg := cli.Config{
		centered: false
		color:    'green'
	}
	c := new(cfg)
	assert !c.centered
	assert c.color == 'green'
}
