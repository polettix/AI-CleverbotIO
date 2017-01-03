# NAME

AI::CleverbotIO - A Perl wrapper for the cleverbot.io API

# VERSION

This document describes AI::CleverbotIO version {{\[ version \]}}.

# SYNOPSIS

    use AI::CleverbotIO;

    my $cleverbot = AI::CleverbotIO->new(
       key => $ENV{CLEVERBOT_API_KEY},
       nick => $ENV{CLEVERBOT_NICK},
       user => $ENV{CLEVERBOT_API_USER},
    );

    # call to create() is mostly safe, you might get an error
    # back but still 200 OK. You can avoid this (and wasting one
    # API call) if you know the nick is already active for these
    # API credentials.
    $cleverbot->create();

    # then, it's just... ask()
    my $answer = $cleverbot->ask('Hello darling!');
    say $answer->{response};

# DESCRIPTION

This module allows you to interact with the API served by
[https://cleverbot.io](https://cleverbot.io).

# ACCESSORS

## key

    my $api_key = $obj->key;

Read-only accessor to the API key. MUST be provided upon instantiation.

## endpoints

    my $endpoints_hashref = $obj->endpoints;

Read-only accessor to a hash reference whose keys are the strings `ask`
and `create` and the corresponding values are the API endoints (URIs).
The default is:

    {
       ask    => 'https://cleverbot.io/1.0/ask',
       create => 'https://cleverbot.io/1.0/create',
    }

## logger

    my $logger = $obj->logger;

Read-only accessor to the logger object ([Log::Any](https://metacpan.org/pod/Log::Any) compatible). See
["BUILD\_logger"](#build_logger) for the default value.

## nick

    $obj->nick($some_string);
    my $nick = $obj->nick;

Read-write accessor to the nick for invoking API calls. If not set, it
is set after a call to ["create"](#create). See also ["has\_nick"](#has_nick).

## ua

    my $ua = $obj->ua;

Read-only accessor to the user agent object ([HTTP::Tiny](https://metacpan.org/pod/HTTP::Tiny) compatible). See
[BUILD\_ua](https://metacpan.org/pod/BUILD_ua) for the default value.

## user

    my $api_user = $obj->user;

Read-only accessor to the API user. MUST be provided upon instantiation.

# METHODS

## BUILD\_logger

Called automatically if ["logger"](#logger) is not set. By default, it
returns whatever ["get\_logger" in Log::Any](https://metacpan.org/pod/Log::Any#get_logger) provides, but you can
easily override this in a derived class.

## BUILD\_ua

Called automatically if ["ua"](#ua) is not set. By default, it returns
a plain new instance of [HTTP::Tiny](https://metacpan.org/pod/HTTP::Tiny), without options.

## ask

    my $answer = $obj->ask($some_text);

Send a _ask_ API request. The returned `$answer` is a hash reference
derived by the JSON decoding of the response body, e.g.:

    {
       status   => 'success',
       response => 'Hullo'
    }

## create

    my $answer = $obj->create();
    my $other  = $obj->create($other_nick);

Send a _create_ API request. The returned `$answer` is a hash reference
derived by the JSON decoding of the response body, e.g.:

    {
       status => 'success',
       nick   => 'NickTheRobot',
    }

If the current ["nick"](#nick) has already been used for creation, the API call
will fail partially in that status 200 will be returned, but the `status`
field in the answer will contain an error about the fact that the nick
already exists (`Error: reference name already exists`). You can safely
ignore this error.

You can optionally pass a different `other_nick`. This will be set as
["nick"](#nick) and used for creation (this will overwrite whatever ["nick"](#nick)
contains though).

## has\_nick

    say $obj->nick if $obj->has_nick;
    say 'no nick yet' unless $obj->has_nick;

Predicate to check whether a ["nick"](#nick) is already set or not.

# BUGS AND LIMITATIONS

Report bugs either through RT or GitHub (patches welcome).

# SEE ALSO

[https://cleverbot.io](https://cleverbot.io).

# AUTHOR

Flavio Poletti <polettix@cpan.org>

# COPYRIGHT AND LICENSE

Copyright (C) 2017 by Flavio Poletti <polettix@cpan.org>

This module is free software. You can redistribute it and/or modify it
under the terms of the Artistic License 2.0.

This program is distributed in the hope that it will be useful, but
without any warranty; without even the implied warranty of
merchantability or fitness for a particular purpose.
