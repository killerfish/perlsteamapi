#!/usr/bin/perl

use strict;
use warnings;

BEGIN { push @INC, './lib' }			#You can remove this, if you install the module
use Data::Dumper;
use Steamwebapi;

#Create object
my $object = Steamwebapi->new();

print "---------------------------------------------METHOD: GetServerInfo----------------------------------------------------\n";

my $result = $object->GetServerInfo();
print Dumper $result;



print "\n---------------------------------------------METHOD: UpToDateCheck----------------------------------------------------\n";

$result = $object->UpToDateCheck((appid => 570, version => 37));
print Dumper $result;



print "\n---------------------------------------------METHOD: IsPlayingSharedGame----------------------------------------------------\n";

my $your_api_key = "";
my %topass = (steamid => 76561198052285537, relationship => "all", key => $your_api_key);
$result = $object->IsPlayingSharedGame(%topass);
print Dumper $result;

