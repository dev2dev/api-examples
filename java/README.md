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

    $ java -jar target/stories-1.0-SNAPSHOT.jar gzt4hmgzc6q8dm2avm4ubzck PXzwhpDdnx "Williamsburg, NY"
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
