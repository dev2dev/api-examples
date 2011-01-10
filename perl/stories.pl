#!/usr/bin/env perl -wT

use strict;

unless (@ARGV == 3) {
  warn "Usage: $0 <developer key> <shared secret> <location>";
  exit 1;
}

my $stories = StoryFinder->new($ARGV[0], $ARGV[1])->find_stories($ARGV[2]);
if (@$stories == 0) {
  print "Found 0 stories\n";
} else {
  print sprintf("Found %d stories:\n", scalar(@$stories));
  for my $story (@$stories) {
    print "  $story->{title}\n";
  }
}

exit;

package StoryFinder;

use Digest::MD5 qw(md5_hex);
use JSON qw(from_json);
use LWP::UserAgent ();
use URI::Escape qw(uri_escape);

use constant BASE_URL => "http://hyperlocal-api.outside.in/v1.1";

sub new {
  my ($class, $key, $secret) = @_;
  bless {key => $key, secret => $secret}, $class;
}

sub find_stories {
  my ($self, $name) = @_;
  $self->request(sprintf("/locations/named/%s", uri_escape($name)), sub {
    my $locations = from_json(shift->content())->{locations};
    die "No location named $name\n" if @$locations == 0;
    $self->request(sprintf("/locations/%s/stories", uri_escape($locations->[0]->{uuid})), sub {
      from_json(shift->content())->{stories};
    });
  });
}

sub request {
  my ($self, $path, $block) = @_;
  my $url = URI->new($self->sign(BASE_URL . $path));
  print "Requesting $url\n";
  my $ua = LWP::UserAgent->new();
  my $response = $ua->get($url);
  if ($response->code() == 200) {
    &$block($response);
  } else {
    die sprintf("Request failed with code %d\n", $response->code());
  }
}

sub sign {
  my ($self, $url) = @_;
  sprintf("%s?dev_key=%s&sig=%s", $url, $self->{key}, (md5_hex($self->{key} . $self->{secret} . time)));
}

1;
