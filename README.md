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
3. Add `login_success.html` to the list of included files in `_config.yml` (this option is customizable - see Global Configuration):

  ```yaml
  include: [..., "login_success.html"]
  ```

## Configuration
### Global configuration
Configuration at the global level can be done in your Jekyll configuration file, most likely it is `_config.yml`. Currently, the following are supported:

1. `spritz_client_id` (required): The client ID issued by Spritz:
2. `url` (required): The base URL of your Jekyll site _without_ the final forward slash:
3. `spritz_auto_mode` (optional, defaults to `true`): This can field can be either `true` or `false`. When it is set to true, necessary scripts and tags will be added to the beginning of each posts. If you wish to customize the location of Spritz (called Redicle), set this field to `false` and refer to the section below, `Liquid Tags`.
4. `spritz_login_success_name` (optional, defaults to `login_success.html`): Spritz require a particular HTML file to work, and we have included it with this gem. By default, it is written to the root of your project using the name `login_success.html`. However, if you have had a file with that name, just set this field to another desired name, say, `spritz_login_success.html`. Also, include this name in the list of included files (see step 3 of Installation).

### Local configuration
In posts that you don't want Spritz to be enabled, set `spritz` to `false` in their front-matter:

  ```yaml
  spritz: false
  ```

### Liquid Tags
Clearly, Spritz requires some scripts in order for it to work. More specifically, it needs [jQuery](http://jquery.com/) and Spritz's script to work. By default, that is, when `spritz_auto_mode` is `true`, these scripts and the Redicle are placed at the beginning of each post. If you wish to customize these behaviors, for example, you are using your own jQuery, you can set `spritz_auto_mode` to `false` and manually place those scripts and Redicle at desired positions.

1. `spritz_scripts`: Returns the necessary HTML tags to import required files. If you are already using jQuery, this tag should appear _after_ the `script` tag that imports jQuery.
2. `spritz_redicle`: Place the Spritz Redicle.
