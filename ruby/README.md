This example uses Ruby to search for the most recent stories in Brooklyn, NY.

## Prerequisites

The application requires the JSON gem. You can install it like so:

    $ sudo gem install json

## Usage

    $ ./brooklyn-stories.rb <developer key> <shared secret>
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/named/Brooklyn,%20NY?dev_key=<key>&sig=<sig>
    Requesting http://hyperlocal-api.outside.in/v1.1/locations/a02aa3e4-2aaa-41d7-b9d7-45642eb1c557/stories?dev_key=<key>&sig=<sig>
    Found 10 stories:
      Lost City Asks "Who Goes to Sam's?"
      Man Wounded in Police Involved Shooting in Brooklyn
      Torino:Margolis presents “Electric Body Interact”
      NU HOTEL: TWELVE ROOMS WITH A VIEW
      Lowe's Profit Rises 17%
      Here And Now
      Brooklyn Law students in library run off by Diesel photo shoot
      The Brooklyn School of Black Visual Artists
      Coney’s Last Gasp
      Lowe's Earnings Rise 17%
