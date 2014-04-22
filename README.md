# Spritz for Jekyll
This is a plugin for Jekyll that attempts to simplify the process of using [Spritz](http://www.spritzinc.com/) on your Jekyll-powered sites.

## Prerequisites
1. You need a client ID issued by Spritz. [Register here](http://www.spritzinc.com/developers/) to get one.
2. Download this file `https://sdk.spritzinc.com/js/1.0/examples/login_success.html` as `login_success.html` and put it in your Jekyll project root.

## Installation
1. Install this gem:

        gem install spritz_for_jekyll
2. Add this gem to the list of gems in `_config.yml`:

  ```yaml
  gems: [..., "spritz_for_jekyll"]
  ```

## Configuration
1. In `_config.yml`, set `spritz_client_id` to the client ID issued by Spritz:

  ```yaml
  spritz_client_id: "your client ID"
  ```
2. Also in `_config.yml`, set `url` to the base URL of your Jekyll site _without_ the final forward slash:

  ```yaml
  url: http://www.example.com # Not http://www.example.com/
  ```

3. In posts that you don't want Spritz to be enabled, set `spritz` to `false` in their front-matter:

  ```yaml
  spritz: false
  ```

4. `jekyll build`

