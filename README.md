# Spritz for Jekyll
This is a plugin for Jekyll that attempts to simplify the process of using [Spritz](http://www.spritzinc.com/) on your Jekyll-powered sites.

## Prerequisites
1. You need a client ID issued by Spritz. [Register here](http://www.spritzinc.com/developers/) to get one.

## Installation
1. Install this gem:

        gem install spritz_for_jekyll
2. Add this gem to the list of gems in `_config.yml`:

  ```yaml
  gems: [..., "spritz_for_jekyll"]
  ```

## Configuration
### Global configuration
Configuration at the global level can be done in your Jekyll configuration file, most likely it is `_config.yml`. Currently, the following are supported:

1. `spritz_client_id` (required): The client ID issued by Spritz:
2. `spritz_auto_mode` (optional, defaults to `true`): This can field can be either `true` or `false`. When it is set to true, necessary scripts and tags will be added to the beginning of each posts. If you wish to customize the location of Spritz (called Redicle), set this field to `false` and refer to the section below, `Liquid Tags`.

### Local configuration
In posts that you don't want Spritz to be enabled, set `spritz` to `false` in their front-matter:

  ```yaml
  spritz: false
  ```

### Liquid Tags
Clearly, Spritz requires some scripts in order for it to work. More specifically, it needs [jQuery](http://jquery.com/) and Spritz's script to work. By default, that is, when `spritz_auto_mode` is `true`, these scripts and the Redicle are placed at the beginning of each post. If you wish to customize these behaviors, for example, you are using your own jQuery, you can set `spritz_auto_mode` to `false` and manually place those scripts and Redicle at desired positions.

1. `spritz_scripts`: Returns the necessary HTML tags to import required files. If you are already using jQuery, this tag should appear _after_ the `script` tag that imports jQuery.
2. `spritz_redicle`: Place the Spritz Redicle.
