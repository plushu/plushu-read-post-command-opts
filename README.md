# plushu-read-post-command-opts

This plugin extends Plushu's normal option parsing to parse global options
present on the command line after the command.

In its normal operation, Plushu will only recognize options provided by plugins
before the command (the first non-option argument). Any plugins *after* the
command are meant to be handled within the context of that command, which may
be different than the option's context when used in a pre-command global sense.

(For example, the "-v" in "plushu -v" could mean "print Plushu's version",
while a "-v" in "plushu ping -v example.com" would mean "ping example.com
verbosely".)

Any global options that a command is meant to recognize as well are meant to be
handled by that command (where it might perform additional checks that wouldn't
be applied at the global scope).

In conclusion, using this plugin is **not recommended**. The position of an
option is meant to be significant in Plushu: installing a plugin to remove that
significance is like [aliasing "quti" to "quit"][1].

[1]: http://comments.gmane.org/gmane.games.fps.halflife.server/15330
