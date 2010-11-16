This example uses Java to search for the most recent stories in a location.

## Prerequisites

The project requires [Maven](http://maven.apache.org/) and [Java SE 6](http://www.oracle.com/technetwork/java/javase/overview/index.html).

## Building

You can build an executable jar like so:

    $ mvn package

## Usage

    java -jar stories-SNAPSHOT-1.0.jar <developer key> <shared secret> <location>

See [https://github.com/outsidein/api-examples](https://github.com/outsidein/api-examples) for details on how to specify location names.

### Example

    $ java -jar stories.jar gzt4hmgzc6q8dm2avm4ubzck PXzwhpDdnx "Williamsburg, NY"
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/named/Williamsburg%2C%20NY?dev_key={key}&sig={sig}
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/6fd7d997-ec5c-463d-bc65-2a6d14c7d123/stories?dev_key={key}&sig={sig}
    Found 10 stories:
      Sunday 21st: THE WORLD WE KNEW at Club Europa  Brooklyn
      Economists say concerns about strategic default are overblown ... and more
      Bankruptcy trips up Brooklyn developer
      Nai Tapas Bar Launches at Former Xunta Space on Monday
      The Real Deal on the town…
      Brooklyn Today: Monday, November 15, 2010
      Chapel Club played CMJ w/ Everything Everything & Blood Red Shoes (pics), playing SXSW 2011 (intial lineup)
      No Age played skate parties @ KCDC & Don Hill's (pics & video)
      Shopping Local
      Link About It: This Week's Picks
