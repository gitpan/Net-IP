use Test::More tests => 19;

BEGIN { use_ok('Net::IP', qw(:PROC)); }

$ip = new Net::IP('dead:beef:0::/48',6);

isa_ok($ip, 'Net::IP', $Net::IP::ERROR);

is($ip->binip(),'11011110101011011011111011101111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000',$ip->error());
is($ip->ip(),'dead:beef:0000:0000:0000:0000:0000:0000',$ip->error());
is($ip->short(),'dead:beef::',$ip->error());
ok($ip->prefixlen() == 48,$ip->error());
ok($ip->version() == 6,$ip->error());
is($ip->mask(),'ffff:ffff:ffff:0000:0000:0000:0000:0000',$ip->error());
is($ip->iptype(),'UNASSIGNED',$ip->error());
is($ip->reverse_ip(),'0.0.0.0.f.e.e.b.d.a.e.d.ip6.arpa.',$ip->error());
is($ip->last_ip(),'dead:beef:0000:ffff:ffff:ffff:ffff:ffff',$ip->error());

$ip->set('202.31.4/24',4);
is($ip->ip(),'202.31.4.0',$ip->error());

$ip->set(':1/128');
is($ip->error(),'Invalid address :1 (starts with :)',$ip->error());
ok($ip->errno() == 109,$ip->error());


$ip->set('ff00:0:f000::');
$ip2 = new Net::IP('0:0:1000::');
is($ip->binadd($ip2)->short(),'ff00:1::',$ip->error());

$ip->set('::e000:0/112');
$ip2->set('::e001:0/112');
ok($ip->aggregate($ip2)->prefixlen() == 111,$ip->error());

$ip2->set('::dfff:ffff');
ok($ip->bincomp('gt',$ip2) == 1,$ip->error());

$ip->set('::e000:0 - ::e002:42');
is(($ip->find_prefixes())[2],'0000:0000:0000:0000:0000:0000:e002:0040/127',$ip->error());

$ip->set('ffff::/16');
$ip2->set('8000::/16');

ok($ip->overlaps($ip2) == $IP_NO_OVERLAP,$ip->error());

1;
