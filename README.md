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

For development:

  * inotify (or fswatch)
  * sassc or sass to handle .scss / .sass files
  * gettext to process .pot / .po files

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

    127.0.0.1  example.test

## Configure PostgreSQL

Add the user role `zotonic` with all permissions on the database `zotonic`.
The user should be able to login using the password `zotonic` from
localhost:

    $ sudo -u postgres psql (enter your OS password)

And then:

    postgres=# CREATE USER zotonic WITH PASSWORD 'zotonic';
    postgres=# CREATE DATABASE zotonic WITH OWNER = zotonic ENCODING = 'UTF8';
    postgres=# GRANT ALL ON DATABASE zotonic TO zotonic;

## Start Zotonic

For development, start Zotonic with the included script:

    ./start.sh

This calls `bin/zotonic debug`

Zotonic will start and you will see the Erlang command prompt.

You can stop Zotonic by typing twice ctrl-C.

You can now visit the site: https://example.test:8443/

Be sure to accept the self-signed certificate.
Chrome users: click in the white and type: `thisisunsafe`

## Admin interface

The admin interface is at: https://example.test:8443/admin/

The username is `admin` and the password is also `admin`.
(Note that the `admin` password can only be used from a local network address.)

## Check the status of the running Zotonic

On the commmnd line type:

    bin/zotonic status

Or to see all the commands:

    bin/zotonic

This will show all the commands:

    USAGE: /home/you/zotonic-example/bin/zotonic (options) [command] 

    Where [command] is one of: 
       addsite          Add a site and install database
       compile          Compile all modified erlang files in the background.
       compilefile      Compile a specific erlang file.
       config           Show Zotonic and Erlang configuration.
       configfiles      List Zotonic config files being used.
       configtest       Test if the Zotonic config files can be read.
       connectdb        Connect to PostgreSQL using the Zotonic database configuration.
       createdb         Create the PostgreSQL database and schema for a site.
       debug            Start Zotonic in the foreground with the Erlang shell.
       dispatch         Show dispatch information for a site or url.
       etop             Show top processes running in the Erlang VM.
       flush            Flush all caches of all sites or a specific site.
       load             Force reload of an Erlang module.
       logtail          Show the last lines of the error and console logs.
       restart          Restart Zotonic and all sites without restarting the Erlang VM.
       restartsite      Restart a site.
       rpc              Call an Erlang function and display the result.
       runtests         Run the specified tests from the Zotonic module test directories.
       shell            Open an Erlang shell on the running Erlang VM.
       siteconfig       Show the configuration of a site.
       siteconfigfiles  List the config files used for a site.
       sitedir          Show the path to the site's Erlang application.
       sitetest         Run the tests for a site.
       start            Start Zotonic in the background.
       start_nodaemon   Start Zotonic in the foreground but without the Erlang shell.
       startsite        Start a site.
       status           Show if Zotonic is running and list the status of all sites.
       stop             Stop the Erlang VM running Zotonic.
       stopsite         Stop a site.
       update           Update the server. Compiles and loads any new code, flushes caches and rescans all modules.
       wait             Wait for a max timeout till Zotonc is running and responding to a ping.

    See http://zotonic.com/docs/latest/manuals/cli.html for more info. 

    Options: 
      -v : Prints Zotonic version 
