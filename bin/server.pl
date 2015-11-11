#!/usr/bin/env perl

use strict;
# use lib::abs '../lib';
use lib "./lib";

use Local::Hackathon::Server;

Local::Hackathon::Server->new->run();
