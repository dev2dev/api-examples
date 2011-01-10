This example uses Perl to search for the most recent stories in a location.

## Prerequisites

The example requires these modules:

* Digest::MD5
* JSON
* LWP::UserAgent
* URI::Escape

You can install each module like so:

    $ sudo perl -MCPAN -e 'install Digest::MD5'

## Usage

    $ stories.pl gzt4hmgzc6q8dm2avm4ubzck PXzwhpDdnx 'Williamsburg, NY'
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/named/Williamsburg%2C%20NY?dev_key=gzt4hmgzc6q8dm2avm4ubzck&sig=45fff078bf7c550454d9e7fd47558a3a
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/6fd7d997-ec5c-463d-bc65-2a6d14c7d123/stories?dev_key=gzt4hmgzc6q8dm2avm4ubzck&sig=6ad220d21e92a30cda344e06aa2ad7be
    Found 10 stories:
      The Sexed-Up Student With Plenty of Surrogates But No Real Thing
      Gary U.S. Bonds, Debbie Gibson, Tiffany, Brooke Shields, Pains, Surfer Blood Trail, Destroyer, Marnie Stern & other tix
      Jan 15 & 16: Every Beatles Song on Ukulele
      East Williamsburg Photo Du Jour: Vandervoort Place
      Eight Winter Wine Events Near NYC
      Crif Dogs Williamsburg Shooting for Wednesday
      Platt Considers Lotus of Siam; Rob and Robin on Williamsburg’s New Grub Hub
      Hamptons sales data indicates "slow recovery," Walmart execs to be no-shows at City Council hearing ... and more
      Task New York Store Profile
      Movies Pick: Gangs of New York
