use Crypt::ScryptKDF qw(scrypt_hex);
use Time::HiRes qw(usleep time);


# Settings
my $OrgSalt = "Please replace this value with unique long random string! E.g.: NYLVfq7kKUc9Aj7KtddMs7ECZV3dloBYRN2wTQigMlQfmoyHqu";
my $MinLength = 10;
my $scryptNLog2 = 17;
my $scryptReservedTime = 3000000;
my $UsersFile = "vpn-users.txt";


# Code starts here
if ($ARGV[0] eq "--measure-time") {
  print("Measuring scrypt execution time...\n");
  my $average = 0;
  my $max = 0;
  for (my $i=0; $i < 15; $i++) {
    my $start = time();
    scrypt_hex("dummy-password".$OrgSalt, "dummy-user", 2**$scryptNLog2, 8, 1, 32);
    my $elapsed = (time()-$start)*1000000;
    printf("Iteration %i time %.0f\n", $i, $elapsed);
    $average += $elapsed;
    if ($max < $elapsed) {
      $max = $elapsed;
    }
    usleep(50000);
  }
  $average /= 15;
  printf("\nAverage time %.0f\nMaximum time %.0f\n", $average, $max);
  exit 1;
}


my $user = $ENV{"username"};
my $pass = $ENV{"password"};

my $cn = lc($ENV{"common_name"});

$user = lc($user);
$user =~ s/^\s+|\s+$//g;
$pass =~ s/^\s+|\s+$//g;
$cn =~ s/^\s+|\s+$//g;

my $firstdelay = int(rand($scryptReservedTime/4));
usleep($firstdelay);

if ($cn ne $user || length($user) < 1 || length($pass) < $MinLength) {
  usleep($scryptReservedTime + int(rand(2000000)) - $firstdelay);
  exit 1;
}

open my $fh, '<', $UsersFile;
chomp(my @userents = <$fh>);
close $fh;

foreach (@userents) {
  my @userent = split(/\s/, $_);
  if (lc($userent[0]) eq $user && length($userent[1]) == 64) {
    my $start = time();
    if (lc($userent[1]) eq scrypt_hex($pass.$OrgSalt, $user, 2**$scryptNLog2, 8, 1, 32)) {
      exit 0;
    } else {
      my $elapsed = (time()-$start)*1000000;
      my $tts = $scryptReservedTime + int(rand(2000000)) - $firstdelay - int($elapsed);
      if ($tts > 0) {
        usleep($tts);
      }
      exit 1;
    }
  }
}

usleep($scryptReservedTime + int(rand(2000000)) - $firstdelay);
exit 1;
