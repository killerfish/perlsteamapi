package Steamwebapi;

use strict;
use warnings;
use Carp;
use Exporter;
use LWP::Simple;

our $VERSION     = 1.00;
our $ABSTRACT    = "Module for Valve Steam Web API.";

my $server = "api.steampowered.com";
my $wget = 0;
#--------------------------------------------------INTERFACE LIST---------------------------------#
use constant {
	APPS => "ISteamApps",
	ECONOMY => "ISteamEconomy",
	NEWS => "ISteamNews",
	STORAGE => "ISteamRemoteStorage",
    	USER => "ISteamUser",
    	STATS => "ISteamUserStats",
    	SERVICE => "IPlayerService",
	UTIL => "ISteamWebAPIUtil",
};

#--------------------------------------------------METHODS LIST------------------------------------#
my $methods = {
	"GetAppList" => {
		interface => APPS, 
		version => 2
	},
	"UpToDateCheck" => {
		interface => APPS,
		version => 1,
	},
	"GetAssetClassInfo" => {
		interface => ECONOMY,
		version => 1,
	},
	"GetAssetPrices" => {
		interface => ECONOMY,
		version => 1,
	},
	"GetNewsForApp" => {
		interface => NEWS,
		version => 2,
	},
	"GetUGCFileDetails" => {
		interface => STORAGE,
		version => 1,
	},
	"GetFriendList" => {
		interface => USER,
		version => 1,
	},
	"GetPlayerBans" => {
		interface => USER,
		version => 1,
	},
	"GetPlayerSummaries" => {
		interface => USER,
		version => 2,
	},
	"GetUserGroupList" => {
		interface => USER,
		version => 1,
	},
	"ResolveVanityURL" => {
		interface => USER,
		version => 1,
	},
	"GetGlobalAchievementPercentagesForApp" => {
		interface => STATS,
		version => 2,
	},
	"GetNumberOfCurrentPlayers" => {
		interface => STATS,
		version => 1,
	},
	"GetPlayerAchievements" => {
		interface => STATS,
		version => 1,
	},
	"GetSchemaForGame" => {
		interface => STATS,
		version => 2,
	},
	"GetUserStatsForGame" => {
		interface => STATS,
		version => 2,
	},
	"GetRecentlyPlayedGames" => {
		interface => SERVICE,
		version => 1,
	},
	"GetOwnedGames" => {
		interface => SERVICE,
		version => 1,
	},
	"GetSteamLevel" => {
		interface => SERVICE,
		version => 1,
	},
	"GetBadges" => {
		interface => SERVICE,
		version => 1,
	},
	"GetCommunityBadgeProgress" => {
		interface => SERVICE,
		version => 1,
	},
	"GetServerInfo" => {
		interface => UTIL,
		version => 1,
	},
	"GetSupportedAPIList" => {
		interface => UTIL,
		version => 1,
	},
};

sub listobj {
        my $funcname = (caller(1)) [3];
        $funcname =~ s/^.*:://;
	my $obj = {
		method => $funcname,
		interface => $methods->{$funcname}->{interface},
		version => $methods->{$funcname}->{version},
	};
        return $obj;
}

sub wget {
        my ($self, $value) = @_;
        if (@_ == 2) {
                $wget = $value;
        }
        return $wget;
}

sub steamid {
	my ($self, $value) = @_;
	if (@_ == 2) {
		$self->{steamid} = $value;
	}
	return $self->{steamid} if defined $self->{steamid};
}

sub apikey {
        my ($self, $value) = @_;
        if (@_ == 2) {
                $self->{apikey} = $value;
        }
        return $self->{apikey} if defined $self->{apikey};
}

sub new {
	my ($class, %args) = @_;
	my $self;
	if(@_ == 1) {
		$self = {};
	}
	if(@_ == 2) {
		$self = {
			"apikey" => $args{apikey}
		};
	}
  	return bless $self, $class;
}

sub GetAppList {
	my $self = shift;
	my $list = listobj();
	return $self->fetch($list);
}

sub UptoDateCheck {
	my ($self, %args) = @_;
        croak("Cant Proceed, No appid provided") if(!($args{appid}));
	croak("Cant Proceed, No version provided") if(!($args{version}));
        my $list = listobj();
        return $self->fetch($list, %args);
}

sub GetAssetClassInfo {
	my ($self, %args) = @_;
        croak("Cant Proceed, No appid provided") if(!($args{appid}));
        croak("Cant Proceed, No class count provided") if(!($args{class_count}));
	croak("Cant Proceed, No class id provided") if(!($args{class_id}));
        my $list = listobj();
        return $self->fetch($list, %args);
}

sub GetAssetPrices {
	my ($self, %args) = @_;
        croak("Cant Proceed, No appid provided") if(!($args{appid}));
        my $list = listobj();
        return $self->fetch($list, %args);
}

sub GetNewsForApp {
	my ($self, %args) = @_;
	croak("Cant Proceed, No appid provided") if(!($args{appid}));
    	my $list = listobj();
    	return $self->fetch($list, %args);
}

sub GetUGCFileDetails {
	my ($self, %args) = @_;
        croak("Cant Proceed, No appid provided") if(!($args{appid}));
	croak("Cant Proceed, No ugcid provided") if(!($args{ugcid}));
        my $list = listobj();
        return $self->fetch($list, %args);
}

sub GetFriendList {
	my ($self, %args) = @_;	
	if (not defined $args{key}) {
                $args{key} = $self->{apikey} or croak "Steam ID cannot be blank";
        }
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
        return $self->fetch($list, %args);
}
sub GetPlayerBans {
	my ($self, %args) = @_;
        croak("Cant Proceed, No steamid list provided") if(!($args{steamids}));
	my $list = listobj();
        return $self->fetch($list, %args);
}

sub GetPlayerSummaries {
	my ($self, %args) = @_;
        croak("Cant Proceed, No steamid list provided") if(!($args{steamids}));
	my $list = listobj();
        return $self->fetch($list, %args);	
}

sub GetUserGroupList {
	my ($self, %args) = @_;
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
        return $self->fetch($list, %args);	
}

sub ResolveVanityURL {
	my ($self, %args) = @_;
        croak("Cant Proceed, No vanity url provided") if(!($args{vanityurl}));
	my $list = listobj();
        return $self->fetch($list, %args);	
}

sub GetGlobalAchievementPercentagesForApp {
	my ($self, %args) = @_;
        croak("Cant Proceed, No game id provided") if(!($args{gameid}));
	my $list = listobj();
        return $self->fetch($list, %args);	
}

sub GetNumberOfCurrentPlayers {
	my ($self, %args) = @_;
        croak("Cant Proceed, No app id provided") if(!($args{appid}));
	my $list = listobj();
        return $self->fetch($list, %args);	
}

sub GetPlayerAchievements {
	my ($self, %args) = @_;
    	croak("App ID cannot be blank") if(!($args{appid}));
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
    	return $self->fetch($list, %args);
}

sub GetSchemaForGame {
	my ($self, %args) = @_;
        croak("Cant Proceed, No app id provided") if(!($args{appid}));
	my $list = listobj();
        return $self->fetch($list, %args);	
}

sub GetUserStatsForGame {
	my ($self, %args) = @_;
    	croak("App ID cannot be blank") if(!($args{appid}));
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
    	return $self->fetch($list, %args);
}

sub GetRecentlyPlayedGames {
	my ($self, %args) = @_;	
	if (not defined $args{key}) {
                $args{key} = $self->{apikey} or croak "Steam ID cannot be blank";
        }
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
        return $self->fetch($list, %args);
}

sub GetOwnedGames {
	my ($self, %args) = @_;	
	if (not defined $args{key}) {
                $args{key} = $self->{apikey} or croak "Steam ID cannot be blank";
        }
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
        return $self->fetch($list, %args);
}
sub GetSteamLevel {
	my ($self, %args) = @_;	
	if (not defined $args{key}) {
                $args{key} = $self->{apikey} or croak "Steam ID cannot be blank";
        }
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
        return $self->fetch($list, %args);
}
sub GetBadges {
	my ($self, %args) = @_;	
	if (not defined $args{key}) {
                $args{key} = $self->{apikey} or croak "Steam ID cannot be blank";
        }
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
        return $self->fetch($list, %args);
}
sub GetCommunityBadgeProgress {
	my ($self, %args) = @_;	
	if (not defined $args{key}) {
                $args{key} = $self->{apikey} or croak "Steam ID cannot be blank";
        }
    	if (not defined $args{steamid}) {
		$args{steamid} = $self->{steamid} or croak "Steam ID cannot be blank";
    	}
	my $list = listobj();
        return $self->fetch($list, %args);
}
sub GetServerInfo {
	my $self = shift;
	my $list = listobj();
	return $self->fetch($list);
}
sub GetSupportedAPIList {
	my ($self, $list);
	if(@_ == 1) {
		$self = shift;
		$list = listobj();
	}
	if(@_ == 2) {
		$self = shift;
		my %args = shift;
		$list = listobj();
        	return $self->fetch($list, %args);	
	}
	return $self->fetch($list);
}

sub fetch {
    	my ($self, $list, %params) = @_;
    	my $url = "http://".$server."/".$list->{interface}."/".$list->{method}."/v000".$list->{version};
	if (keys %params) {
		my $urlparams = join "&", map {"$_=$params{$_}"} keys %params;
		$url .= "/?".$urlparams;
	}
	if ($wget == 0) {
    		my $response = get $url;
    		croak "Couldn't get $url" unless defined $response;
		return $response; 
	}
	return system("wget -q -O - $url");
}
1;

__END__

=head1 NAME

Steamwebapi

=head1 VERSION

Version 1.00

=head1 SYNOPSIS

This module provides an interface to Valve steam web api.

=head1 methods
	
=head1 AUTHOR

Usman Raza, B<C<usman.r123 at gmail.com>>

=head1 SUPPORT

You can find documentation for this module with the perldoc command. Also check the example provided.

    perldoc Vdfparser

Github repo https://github.com/killerfish/perlsteamapi

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Usman Raza.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
