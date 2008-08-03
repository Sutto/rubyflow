RUBYFLOW
========
Developed by Peter Cooper - 2008

All code developed by Peter Cooper within this project is in the public domain.
Plugins, Rails, and derivative code is licensed as it was originally (mostly MIT).

This code is entirely unsupported, lacks tests, and could well make your machine
explode. If you use it, you understand this and accept all the risks.


Getting Started
---------------
I have not tested these instructions, but from memory..

1. Rename config/database.yml.dist to database.yml and make the appropriate
configuration changes.

2. Run rake db:migrate to set up your database.

Multiple Sites
--------------

The RubyFlow code is designed to deal with multiple sites from one codebase (although not one installation).
The settings for a particular site are in config/[sitename].yml
The site name for the current installation is set on the first line of config/environment.rb
Current the setting is for "rubyflow", so config/rubyflow.yml is used.
Change the chosen site in config/environment.rb and create your own YML file.

Note that the chosen site name is added as a class to the BODY tag. This makes it easy to use the same
CSS file for multiple sites but apply site specific tweaks with BODY.sitename prefixes in the CSS!