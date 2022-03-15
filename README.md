# zotonic_example

This is an example website for Zotonic.

Zotonic is included as Hex packages.
The example website is in `apps/example_site`

You can add your own websites or adapt it.

## Installation

Make sure that you have installed the dependencies:

 * Erlang OTP  (version 22.3 or newer)
 * PostgreSQL (9.5 or newer)
 * ImageMagick (command line tools `convert` and `identify`)
 * C compiler (gcc)
 * Build tools (GNU Make, reltool etc.)

If you want to use video

 * ffmpeg

For virus checks of uploaded files:

  * clamav

## Build Zotonic

In the top level directory, type:

    make

The build tool rebar3 will be downloaded and after that all
Zotonic Hex packages will be downloaded and compiled.

## Configure the hostname

The example site is assumed to run on port 8000/8443 and with
the hostname `example.test`. The hostname is configured in 
`apps/example_site/priv/zotonic_site.config`

You will need to add the hostname to your `/etc/hosts` file, add
this line:

    example.test  127.0.0.1

## Start Zotonic

For development, start Zotonic with the included script:

    ./start.sh

This calls `bin/zotonic debug`

Zotonic will start and you will see the Erlang command prompt.

You can stop Zotonic by typing twice ctrl-C.

