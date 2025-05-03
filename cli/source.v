module cli

import flag
import os

pub struct Config {
pub:
	color        string
	centered     bool
	show_date    bool
	blink        bool
	show_seconds bool
}

pub fn parse_args() Config {
	mut fp := flag.new_flag_parser(os.args)
	fc := flag.FlagConfig{}

	color := fp.string('color', `c`, 'none', 'digit color', fc)
	nocenter := fp.bool('nocenter', 0, false, 'do not center the clock', fc)
	nodate := fp.bool('nodate', `d`, false, 'do not show the date', fc)
	noblink := fp.bool('noblink', `b`, false, 'disable blinking colon', fc)
	seconds := fp.bool('seconds', `s`, false, 'show seconds (hh:mm:ss)', fc)

	return Config{
		color:        color
		centered:     !nocenter
		show_date:    !nodate
		blink:        !noblink
		show_seconds: seconds
	}
}
