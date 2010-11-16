This example uses C# to search for the most recent stories in a location.

## Prerequisites

To run this example on Linux or Mac OS X, you must install [Mono](http://www.mono-project.com/).

To run it on Windows, TBD

## Building

You can build the executable with Mono like so:

    $ gmcs -r:System.Web.Extensions.dll stories.cs

## Usage

    $ mono stories.exe <developer key> <shared secret> <location>

See [https://github.com/outsidein/api-examples](https://github.com/outsidein/api-examples) for details on how to specify location names.

**Note:** This example doesn't actually work correctly in my environment (Mono/OS X); the runtime throws an exception when deserializing the JSON response from the first API request. Any help figuring out the issue would be appreciated! -bcm

### Example

    $ mono stories.exe gzt4hmgzc6q8dm2avm4ubzck PXzwhpDdnx "Williamsburg, NY"
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/named/Williamsburg,%20NY?dev_key={key}&sig={sig}
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/6fd7d997-ec5c-463d-bc65-2a6d14c7d123/stories?dev_key={key}&sig={sig}
    Found 10 stories
      Napolitano 'open' to fliers' gripes over screening
      4 B'klyn towers top list of city's best sellers
      What's going on Tuesday?
      Bowling for Books
      Williamsburg Activist Takes Issues Global
      Scott Campbell's en fuego
      THIS WEEK IN NYC (11/16-11/21)
      The history of Brooklyn music - in photos
      BUSHWICK: House organ! Vito and allies have their own state-financed newspaper
      ART: The history of Brooklyn music - in photos
