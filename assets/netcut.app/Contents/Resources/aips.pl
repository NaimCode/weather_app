#!/usr/bin/perl
$| = 1;

use File::Basename;
my $dir = dirname(__FILE__);

#my $dir = $RealBin;
 
#my $t=exec2output("ls");

my $cmd="$dir/netcut_mac"; 

print "Running $cmd\n";

killbycmd($cmd);

killbyPort(4623);



run($cmd);






sub exec2output
{
	my $r;
	my $cmd = shift;
    open(my $cmd_fh, "/bin/sh $cmd |");
	while (<$cmd_fh>) {
    print "A line of output from the command is: $_";
	$r.=$_;
	}
close $cmd_fh;
    return $r;

}

sub killbycmd
{
    my $cmd=shift;
	print "run ps\n";
	my $process = `ps -Al | grep $cmd`;
	print "got ps\n";
    foreach(split/\n/,$process)
	{
		#print "process $_  \n";
		my $pidinfo=$_;
		$pidinfo =~ s/\s+/ /g;
		my @info = split /\s+/ , $pidinfo;
		print "PID: $info[2] PPID: $info[3] $info[15]\n";
		if($info[15] eq $cmd&&$info[2]!=$$)
		{
			print "kill $info[2]\n";
			`kill -9 $info[2]`;

			if($info[3]!=1)
			{
				print "kill Parent $info[3]\n";
			`kill -9 $info[3]`;
			}
		}

	}
}

sub run
{
	my $runcmd=shift;
   
while(1)
{
print "Starting netcut $runcmd\n";	
system($runcmd);
print "netcut Exit, Sleep 5 seconds and restart\n";	
sleep(5);
}

 
}
sub getPPidbyPid
{
	my $pid=shift;

$pidinfo = `ps -l -p $pid | grep $pid`;
$pidinfo =~ s/\s+/ /g;
@info = split /\s+/ , $pidinfo;
print "$pidinfo\nPID: 0:$info[0] 1:$info[1] 2:$info[2]\n";
if($info[2]==$pid &&exists $info[3])
  {
	  return $info[3];
  }

return -1;

}

sub killbyPort
{
   my $killport=shift;

   
$listening_port = `netstat -ant | grep LISTEN | grep $killport`;
print $listening_port."\n";
@elements = split /\n/ , $listening_port;

%open_port = ();
foreach $socket (@elements) {
	@tmp = split /\s+/, $socket;
	$open_port{$socket} = [($tmp[0], $tmp[3])];
}

#print "APP:PORT\tPID\tUSER\tVERSION\tPROTOCOL\tSOCKET\n";
foreach $socket (keys %open_port) {
	$open_port{$socket}[1] =~ /\.([0-9]+)$/;
	$port = $1;
	$output = `lsof -ni 4:$port | grep LISTEN`;
	#print "$output";
	chomp $output;
	$output =~ s/\s+/ /g;
	@outputs = split ' ', $output;
	if($port == $killport)
	{


    my $pid=$outputs[1];
	my $ppid=getPPidbyPid($pid);
    my $cmd="kill -9 $pid";
	print "$cmd and PPID is $ppid\n";
    $killoutput=`$cmd`;
	
	if($ppid!=1&&$ppid!=-1)
	{
	$cmd="kill -9 $ppid";	
	$killoutput=`$cmd`;
	print $cmd."\n";	
	}
    #print $killoutput;
	

	}
	#print "$outputs[0]:$port\t$outputs[1]\t$outputs[2]\t$outputs[4]\t$outputs[7]\t\t$outputs[8] $outputs[9]\n" if ($output);
}
} 