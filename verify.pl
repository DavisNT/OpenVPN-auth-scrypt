use Crypt::ScryptKDF qw(scrypt_hex);
use Time::HiRes qw(usleep);


# Settings
my $OrgSalt = "Please replace this value with unique long random string! E.g.: NYLVfq7kKUc9Aj7KtddMs7ECZV3dloBYRN2wTQigMlQfmoyHqu";
my $MinLength = 10;
my $scryptNLog2 = 17;
my $UsersFile = "vpn-users.txt";


# Code starts here
my $user = $ENV{"username"};
my $pass = $ENV{"password"};

my $cn = lc($ENV{"common_name"});

$user = lc($user);
$user =~ s/^\s+|\s+$//g;
$pass =~ s/^\s+|\s+$//g;
$cn =~ s/^\s+|\s+$//g;

usleep(int(rand(1000000)));

if ($cn ne $user || length($user) < 1 || length($pass) < $MinLength) {
  usleep(1000000 + int(rand(1000000)));
  exit 1;
}

open my $fh, '<', $UsersFile;
chomp(my @userents = <$fh>);
close $fh;

foreach (@userents) {
  my @userent = split(/\s/, $_);
  if (lc($userent[0]) eq $user) {
    if ($userent[1] eq scrypt_hex($pass.$OrgSalt, $user, 2**$scryptNLog2, 8, 1, 32)) {
      exit 0;
    } else {
      usleep(int(rand(1500000)));
      exit 1;
    }
  }
}

usleep(1000000 + int(rand(1000000)));
exit 1;
