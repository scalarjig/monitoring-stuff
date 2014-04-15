#!/usr/bin/perl
# vmmonitoring.plx
use warnings;
use strict;


my @now = localtime();
my $datetoday = sprintf("%04d%02d%02d",$now[5]+1900, $now[4]+1, $now[3],);
my $filename = "serverMonitor$datetoday.log";
#print "new filename is , $filename \n";	

my $filesize = -s $filename;
#print $filesize;					
		
open my $fh, '>>', "$filename" or die "Cannot open output.txt: $!";

print $fh "currtime,swapmem,freemem,swapindisk,swaptodisk,usrcpu,syscpu,totalcpu \n" if($. eq 1) ;  
	foreach (1,2,3){
	server_monitor();
	sleep (2);
	}
close $fh; 


sub server_monitor{

my $swapmem ;
my $freemem ;
my $swapindisk;
my $swaptodisk;
my $usrcpu;
my $syscpu;


my @swapmem ;
my @freemem ;
my @swapindisk;
my @swaptodisk;
my @usrcpu;
my @syscpu;


my @vmstat = `vmstat 1 2 |grep -v '^procs'|grep -v 'r'`; 
my @currentdate = `date` ;

foreach my$x (@vmstat){
		#chomp $x;
		(undef,undef,my $p3,my $p4,undef,undef,my $p7,my $p8,undef,undef,undef,undef,my $p13,my $p14,undef,undef,undef) = split(' ',$x);
		
		
		push  @swapmem , "$p3";
		push  @freemem , "$p4";
		
		push  @swapindisk , "$p7";
		push  @swaptodisk , "$p8";
		
		push  @usrcpu , "$p13";
		push  @syscpu , "$p14";
				
	}

open my $fh, '>>', "$filename" or die "Cannot open output.txt: $!";
	 my $datestring = localtime();
	 print $fh "$datestring,$swapmem[1],$freemem[1],$swapindisk[1],$swaptodisk[1],$usrcpu[1],$syscpu[1] \n";
close $fh; 
}

