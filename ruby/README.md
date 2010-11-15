This example uses Ruby to search for the most recent stories in a location.

## Prerequisites

The script requires the JSON gem. You can install it like so:

    $ sudo gem install json

## Usage

    stories.rb <developer key> <shared secret> <location>

See [https://github.com/outsidein/api-examples](https://github.com/outsidein/api-examples) for details on how to specify location names.

### Example

    $ stories.rb  gzt4hmgzc6q8dm2avm4ubzck PXzwhpDdnx "Williamsburg, NY"
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/named/Williamsburg,%20NY?dev_key={key}&sig={sig}
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/6fd7d997-ec5c-463d-bc65-2a6d14c7d123/stories?dev_key={key}&sig={sig}
    Found 10 stories:
      Sunday 21st: THE WORLD WE KNEW at Club Europa  Brooklyn
      Economists say concerns about strategic default are overblown ... and more
      The Real Deal on the town…
      Brooklyn Today: Monday, November 15, 2010
      Chapel Club played CMJ w/ Everything Everything & Blood Red Shoes (pics), playing SXSW 2011 (intial lineup)
      No Age played skate parties @ KCDC & Don Hill's (pics & video)
      Shopping Local
      Link About It: This Week's Picks
      In Williamsburg, Developers Try to Fit In
      NYC home loan volume sees 25 percent drop-off, Earle Graves lists Scarsdale manse ... and more
