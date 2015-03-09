#!/usr/bin/perl
use strict;
use Digest::MD5 qw( md5_hex );
use File::Fetch;

my $kzp_url = 'http://www.kzp.bg/download.php?mode=fileDownload&p_attached_file_id=4956';

die "usage: $0 mails_file.txt [kzp_file.txt]\n" unless ($#ARGV >= 0);
die "cannot open mails file: $!" unless (open(my $f_mails, '<', $ARGV[0]));

my %kzp;
my $kzp_content;

if ($ARGV[1] and -e $ARGV[1]) { # open kzp file
	die "cannot open kzp file: $!" unless (open(my $f_kzp, '<', $ARGV[1]));
	local $/;
	$kzp_content = <$f_kzp>;
} else { # or download the latest version of the file
	print STDERR "- downloading last KZP file...\n";
	my $ff = File::Fetch->new(uri => $kzp_url);
	my $file = $ff->fetch( to => \$kzp_content ) or die $ff->error;
}

$kzp_content =~ s/\r//g;
foreach (split(/\n/, $kzp_content)) {
	$kzp{lc($_)} = 1;
}

while ( <$f_mails> ) {
	chomp;
	my $md5 = md5_hex(lc($_));
	$kzp{$md5} ? print STDERR "- KZP: $_\n" : print "$_\n";
}
