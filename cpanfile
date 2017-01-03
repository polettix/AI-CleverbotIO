requires 'perl',            '5.010';
requires 'Moo',             '2.003000';
requires 'HTTP::Tiny',      '0.070';
requires 'IO::Socket::SSL', '1.56';    # from HTTP::Tiny 0.070 docs
requires 'Net::SSLeay',     '1.49';    # from HTTP::Tiny 0.070 docs

on test => sub {
   requires 'Test::More', '0.88';
   requires 'Path::Tiny', '0.096';
};

on develop => sub {
   requires 'Path::Tiny',        '0.096';
   requires 'Template::Perlish', '1.52';
};
