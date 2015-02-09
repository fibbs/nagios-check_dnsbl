# nagios-check_dnsbl
This is a Nagios plugin to check whether your server is on a DNS blacklist.

## Requirements
1. bash
2. dig

## Installing
Put the file `check_dnsbl.sh` in your plugins directory.

## Usage
`/path/to/your/plugins/check_dnsbl.sh -H <IP address>`

## Example output
`OK - 1.2.3.4 is not on any of 19 DNSBLs`

## DNS blacklists that this plugin checks for
* cbl.abuseat.org
* virbl.dnsbl.bit.nl
* blackholes.five-ten-sg.com
* dnsbl.inps.de
* ix.dnsbl.manitu.net
* no-more-funn.moensted.dk
* combined.njabl.org
* dnsbl.njabl.org
* dnsbl.sorbs.net
* bl.spamcannibal.org
* bl.spamcop.net
* sbl.spamhaus.org
* xbl.spamhaus.org
* pbl.spamhaus.org
* dnsbl-1.uceprotect.net
* psbl.surriel.com
* l2.apews.org
* dnsrbl.swinog.ch
* db.wpbl.info