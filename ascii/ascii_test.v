module ascii

fn test_render_single_zero() {
	out := render_string('0')
	expected := glyph_map[`0`]
	assert out.len == 5
	for i, row in expected {
		assert out[i] == row + ' '
	}
}

fn test_render_two_chars() {
	out := render_string('10')
	for i in 0 .. 5 {
		part1 := glyph_map[`1`][i] + ' '
		part2 := glyph_map[`0`][i] + ' '
		assert out[i] == part1 + part2
	}
}

fn test_unknown_char_uses_space() {
	out := render_string('@')
	space := glyph_map[` `]
	assert out.len == 5
	for i, row in space {
		assert out[i] == row + ' '
	}
}
