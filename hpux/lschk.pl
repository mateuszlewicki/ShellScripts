#!/usr/bin/perl

use strict;
use warnings;


my $LOGDIR="/lawtrans/a699323/logs"
my $LOGFIL="$LOGDIR/lschk_$ENV{'XXPDL'}"

my $LAWDIR=$ENV{'LAWDIR'};
my $secLog="$LAWDIR/system/sec.log";

my @lastSL=`tail -6 $secLog`;

#if ($lastSL[4] =~ /Disabled/){
#if ($lastSL[0] =~ //){

if ($lastSL[0] =~ /$DOW\s$MONTH\s\d{2}\s\d{2}:\d{2}:\d{2}\s$YEAR/){
  if ($lastSL[4] =~ /Disabled/){


    my $out = join("\n",@lastSL);
    `echo "PL: $ENV{'XXPDL'}\n\n$out" | mailx -s "Lawsec" mateusz.lewicki\@atos.net`
  }
};
