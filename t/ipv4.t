use Test::More tests => 23;

BEGIN { use_ok('Net::IP', qw(:PROC)); }

$ip = new Net::IP('195.114.80/24', 4);
isa_ok($ip, 'Net::IP', $Net::IP::ERROR);

is($ip->binip(),'11000011011100100101000000000000',$ip->error());
is($ip->ip(),'195.114.80.0',$ip->error());
is($ip->print(),'195.114.80/24',$ip->error());
ok($ip->prefixlen() == 24,$ip->error());
ok($ip->version() == 4,$ip->error());
ok($ip->size() == 256,$ip->error());
is($ip->binmask(),'11111111111111111111111100000000',$ip->error());
is($ip->mask(),'255.255.255.0',$ip->error());
ok($ip->intip() == 3279048704,$ip->error());
is($ip->iptype(),'PUBLIC',$ip->error());
is($ip->reverse_ip(),'80.114.195.in-addr.arpa.',$ip->error());
is($ip->last_bin(),'11000011011100100101000011111111',$ip->error());
is($ip->last_ip(),'195.114.80.255',$ip->error());

$ip->set('202.31.4/24');
is($ip->ip(),'202.31.4.0',$ip->error());

$ip->set('234.245.252.253/2');
is($ip->error(),'Invalid prefix 11101010111101011111110011111101/2',$ip->error());
ok($ip->errno() == 171,$ip->error());

$ip->set('62.33.41.9');
$ip2 = new Net::IP('0.1.0.5');
is($ip->binadd($ip2)->ip(),'62.34.41.14',$ip->error());

$ip->set('133.45.0/24');
$ip2 = new Net::IP('133.45.1/24');
ok($ip->aggregate($ip2)->prefixlen() == 23,$ip->error());

$ip2 = new Net::IP('133.44.255.255');
ok($ip->bincomp('gt',$ip2) == 1,$ip->error());

$ip = new Net::IP('133.44.255.255-133.45.0.42');
is(($ip->find_prefixes())[3],'133.45.0.40/31',$ip->error());

$ip->set('201.33.128.0/22');
$ip2->set('201.33.129.0/24');

ok($ip->overlaps($ip2) == $IP_B_IN_A_OVERLAP,$ip->error());

1;
