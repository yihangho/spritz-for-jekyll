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
Configuration at the global level can be done in your Jekyll configuration file, most likely it is `_config.yml`. All options described below must be nested inside the `spritz` key (refer to the example):

1. `client_id` (required): The client ID issued by Spritz:
2. `url` (optional in some cases, recommended): The base URL of your Jekyll site. It can be a URL itself, or the key that points to another option in the configuration file that contains the URL. (See the example below.)
3. `auto_mode` (optional, defaults to `true`): This can field can be either `true` or `false`. When it is set to true, necessary scripts and tags will be added to the beginning of each posts. If you wish to customize the location of Spritz (called Redicle), set this field to `false` and refer to the section below, `Liquid Tags`.
4. `login_success_name` (optional, defaults to `login_success.html`): Spritz require a particular HTML file to work, and we have included it with this gem. By default, it is written to the root of your project using the name `login_success.html`. However, if you have had a file with that name, just set this field to another desired name, say, `spritz_login_success.html`. Also, include this name in the list of included files (see step 3 of Installation).
5. `spritz_selector` (optional, but highly recommended): A CSS selector that selects the HTML element containing the actual content. By default, Spritz will just load the entire page, including stuff like your site title, copyright statement, etc.
7. `jquery` (optional): Use this option to customize jQuery fallbacks to be used. Can be `false` (disable fallback, not recommended), a String, or an Array.
6. `redicle` (optional): Use this option to customize your Redicle. The value of this option should be a hash containing some or all of these keys: `width`, `height`, `default_speed`, `speed_items`, `control_buttons` and `control_titles`. Refer to the example to see the uses of each of these keys.

#### Example
```yaml
base_url: http://www.example.com
spritz:
  client_id: "12345"
  url: base_url
  # or
  # url: http://www.example.com
  auto_mode: true
  login_success_name: "spritz_login_success.html"
  selector: "div#content"
  jquery: ["asset/js/jquery.js", "//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"]
  redicle:
    width: 500
    height: 200
    default_speed: 300
    speed_items: [200, 300, 400]
    control_buttons: ["back", "pauseplay", "rewind"]
    control_titles:
      back: "Go back"
      pause: "Stop (temporarily)"
      play: "Play"
      rewind: "Restart"
````

### Local configuration
In posts that you don't want Spritz to be enabled, set `spritz` to `false` in their front-matter:

  ```yaml
  spritz: false
  ```

### Liquid Tags
Clearly, Spritz requires some scripts in order for it to work. More specifically, it needs [jQuery](http://jquery.com/) and Spritz's script to work. By default, that is, when `spritz_auto_mode` is `true`, these scripts and the Redicle are placed at the beginning of each post. If you wish to customize these behaviors, for example, you are using your own jQuery, you can set `spritz_auto_mode` to `false` and manually place those scripts and Redicle at desired positions.

1. `spritz_scripts`: Returns the necessary HTML tags to import required files. If you are already using jQuery, this tag should appear _after_ the `script` tag that imports jQuery.
2. `spritz_redicle`: Place the Spritz Redicle.
