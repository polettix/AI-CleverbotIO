#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Exception;

use AI::CleverbotIO;

plan skip_all => 'no CLEVERBOT_USER/CLEVERBOT_KEY pair set'
  unless exists($ENV{CLEVERBOT_USER}) && exists($ENV{CLEVERBOT_KEY});

my $cleverbot;
lives_ok {
   $cleverbot = AI::CleverbotIO->new(
      key  => $ENV{CLEVERBOT_KEY},
      nick => "AI::CleverbotIO Tester",
      user => $ENV{CLEVERBOT_USER},
   );
} ## end lives_ok
'AI::CleverbotIO instantiation lives';

isa_ok $cleverbot, 'AI::CleverbotIO';
diag 'real nick: ' . $cleverbot->nick;

my $answer;
lives_ok { $answer = $cleverbot->ask('How are you doing?') }
  'simple question';
like $answer, qr{(?imxs:[a-z])}, 'response has at least... one letter';
diag "received answer: $answer";

done_testing();
