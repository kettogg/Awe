-- Allows all signals to be connected and/or emitted.
return {
	client  = require('signal.client'),
	-- NOTE: The `tag` file must be loaded before the `screen` one so that
	-- the correct layouts defined in `config.user` are appended to the tags
	-- upon creation.
	tag     = require('signal.tag'),
	screen  = require('signal.screen'),
	naughty = require('signal.naughty'),
	system  = require('signal.system'),
}
