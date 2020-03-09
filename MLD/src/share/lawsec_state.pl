#!/usr/bin/perl

use strict;
use warnings;


# my $LOGDIR="/lawtrans/a699323/logs";
# my $LOGFIL="$LOGDIR/lschk_$ENV{'XXPDL'}";

#my $LAWDIR=$ENV{'LAWDIR'};
#my $secLog="$LAWDIR/system/sec.log";
my $secLog = $ARGV[1]
my $pl = $ARGV[2]
my @mails=qw(mateusz.lewicki@atos.net);
my $mail_list=join(" ", @mails);

while(1){

  unless (-e $secLog ) {
    my $lastSL="Lawson Security: Disabled";
    `echo "PL: $pl\n\n$lastSL\n" | mailx -s "Lawsec" $mail_list` if ($lastSL =~ /Disabled/);}
  else{

    my $DOW=`date +%a`;
    my $MONTH=`date +%b`; #check on HPUX
    my $YEAR=`date +%Y`;

    my @lastSL=`tail -6 $secLog`;

    if ($lastSL[0] =~ /$DOW\s$MONTH\s\d{2}\s\d{2}:\d{2}:\d{2}\s$YEAR/){

      if ($lastSL[4] =~ /Enabled/){ # TMP  return to disabled

        my $out = join("\n",@lastSL);

        `echo "PL: $pl\n\n$out\n" | mailx -s "Lawsec" $mail_list` unless ($ENV{'DBG_SEND_MAILS'} =~ /N|n/);
        `echo "PL: $pl\n\n$out\n"` if ($ENV{'DBG_EXPLICIT'} =~ /Y|y/);
      }
    }
  }
  sleep(60*5);
}
