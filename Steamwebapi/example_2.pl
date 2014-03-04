#!/usr/bin/perl

use strict;
use warnings;

BEGIN { push @INC, './lib' }			#You can remove this, if you install the module
use Data::Dumper;
use Steamwebapi;
use Vdfparser qw(:decode);			#To use Vdfparser, get it from http://www.github.com/killerfish/Vdfparser.git
use JSON::Parse 'json_to_perl';			#To use JSON::Parse, Install from cpan
use XML::Simple;				#To use XML::Simple, Install from cpan

#Create object
my $object = Steamwebapi->new();

print "---------------------------------------------METHOD: GetNumberOfCurrentPlayers----------------------------------------------------\n";

my $result = $object->GetNumberOfCurrentPlayers((appid=> 570, format => "vdf"));
my %r = vdf_decode(data=>$result);
print Dumper \%r;



print "\n-------------------------------------------METHOD: GetBadges--------------------------------------------------------------------\n";

$object->key($your_api_key);
$object->steamid("76561198052285537");
$result = $object->GetBadges();
print Dumper json_to_perl($result);

print "\n-------------------------------------------METHOD: GetSteamLevel-----------------------------------------------------------------\n";

$result = $object->GetSteamLevel((format => "xml"));
my $xmlobj = new XML::Simple;
print Dumper $xmlobj->XMLin($result);
