#!/usr/bin/perl



use strict;

#use warnings;







my $secLog = $ARGV[0];

my $pl = $ARGV[1];

my @mails=qw(mail1 mail2);

my $mail_list=join(" ", @mails);

our $lastDate;



while(1){

    print join "","### START: ",`date +"%D %R"`;

    my @lastSL=`tail -6 $secLog`;



    if ( defined $lastDate ) {

        # Check if test condition is set TESTED
	chomp(my $cifDate=$lastSL[0]);

      if ($lastDate ne $cifDate ){

              print "Found something... sending email\n";

              my $out = join("\n",@lastSL);



             `echo "PL: $pl\n\n$out\n" | mailx -s "AUTO: Lawsec State Changed" $mail_list` unless ($ENV{'DBG_SEND_MAILS'} =~ /N|n/);

             `echo "PL: $pl\n\n$out\n"` if ($ENV{'DBG_EXPLICIT'} =~ /Y|y/);

	
    	     chomp($lastDate=$lastSL[0]);
        }

  } else {

    chomp($lastDate=$lastSL[0]);

    print "init run...\n";

  }



  print join "","### STOP: ",`date +"%D %R"`;

  sleep(60*5);

}
