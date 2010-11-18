jQuery(function($) {
  $('form').submit(function(e) {
    e.preventDefault();

    var inputHandler = new InputHandler();
    inputHandler.setKey($('form input[name=key]').val());
    inputHandler.setSecret($('form input[name=secret]').val());
    inputHandler.setLocationName($('form input[name=location]').val());

    if (inputHandler.validate() != false) {
      $('#results').html('');
      var fetcher = new StoryFetcher(inputHandler.key, inputHandler.secret);
      fetcher.fetchStories(inputHandler.locationName, function(data) {
        if (data.stories.length == 0) {
          $('#results').html(ich.noStories);
        } else {
          $('#results').html(ich.stories({
            total: data.stories.length, stories: data.stories, location: data.location.display_name
          }));
        }
      });
    }
  });
});

function StoryFetcher(key, secret) {
  var BASE_URL = "http://hyperlocal-api.outside.in/v1.1";

  this.key = key;
  this.secret = secret;

  this.fetchStories = function(locationName, onSuccess) {
    var fetcher = this;
    this.request("/locations/named/" + encodeURIComponent(locationName), function(data) {
      var locations = data.locations;
      if (locations.length == 0) {
        alert("No location named " + locationName);
      } else {
        fetcher.request("/locations/" + encodeURIComponent(locations[0].uuid) + "/stories", function(data) {
          onSuccess(data);
        });
      }
    });
  }

  this.request = function(path, onSuccess) {
    var url = this.sign(BASE_URL + path);
    console.log("Requesting " + url);
    $.ajax({
      url: url, dataType: 'json', type: 'GET',
      success: function (data, status, xhr) {
        if (data == null) {
          alert("An error occurred connecting to " + url +
            ". Please ensure that the server is running and configured to allow cross-origin requests.");
        } else {
          onSuccess(data);
        }
      },
      error: function (xhr, status, error) {
        alert("An error occurred - check the server log for a stack trace.");
      }
    });
  }

  this.sign = function(url) {
    var hm = this.key + this.secret + (Math.round(new Date().getTime() / 1000).toString());
    var sig = $.md5(hm);
    return url + "?dev_key=" + this.key + "&sig=" + sig;
  }
}

function InputHandler() {
  this.key = null;
  this.secret = null;
  this.locationName = null;

  var handler = this;

  this.setKey = function(input) { this.acceptInput(input, function(val) { handler.key = val }) };
  this.setSecret = function(input) { this.acceptInput(input, function(val) { handler.secret = val }) };
  this.setLocationName = function(input) { this.acceptInput(input, function(val) { handler.locationName = val }) };

  this.acceptInput = function(val, whenNotBlank) {
    if (val != null) {
      val = val.trim();
      if (val != '') {
        whenNotBlank(val);
      }
    }
  }

  this.validate = function() {
    if (handler.key == null || handler.secret == null || handler.locationName == null) {
      alert("Please fill out all fields.");
      return false;
    } else {
      return true;
    }
  }
}
