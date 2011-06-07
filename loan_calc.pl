#!/usr/bin/perl -w

use strict;

use POSIX qw(ceil floor);

# one for a step-by step rundown, if you like to watch numbers scroll
# up the screen.
my $debug = 0;

# get arguments.  If there were no arguments, explain what is expected.
if (!@ARGV) {
	die "Usage: $0 <\$initial> <\%interest/day> <days>\n";
}
$debug and print "Got: @ARGV\n";

# set input variables, and ensure they fit our needs.
my ($initial, $interest, $days) = @ARGV;
$debug and print "Initial: $initial, interest: $interest, days: $days\n";
($initial =~ /^[0-9.]+$/) or die "Must specify an initial amount! (without dollar sign)\n";
($interest =~ /^[0-9.]+$/) or die "Must specify a daily interest rate!\n";
($interest > 1) and $interest = $interest / 100;
($days =~ /^[0-9.]+$/) or die "Must specify a number of days!\n";
$days = ceil($days);

# store human-parsable interest rate for later use. 
my $interest_rate = $interest*100;

# tally up total debtings/earnings
my $total = $initial;
for (my $x=1; $x<=$days; $x++) {
	$total *= (1+$interest);
	$debug and print "Day $x total: $total\n";
}
my $difference = $total-$initial;
$total = sprintf("%.2f", $total);
$difference = sprintf("%.2f", $difference);

# wrap up
print "$days days later...
\tGiven a loan of \$$initial and a daily interest rate of $interest_rate\%,
\t\$$total will be owed (\$$difference earned/lost)\n";

