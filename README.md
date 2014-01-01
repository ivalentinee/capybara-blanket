# Cucumber::Blanket

Works to extract accumulated [Blanket.js](https://github.com/alex-seville/blanket) coverage data 
from the browser from a Cucumber environment. Accumulated, in this context, means that coverage data
is accumulated from scenario to scenario, in an additive fashion.

## Installation

Add this line to your application's Gemfile:

    gem 'cucumber-blanket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucumber-blanket

## Usage

You should be using Cucumber

Require this gem at the top of `features/support/env.rb` or before using it.

```ruby
require 'cucumber/blanket'
```

Install blanket.js

Two javascript files are bundled;
* blanket.js -- the library itself
* cucumber-blanket.js -- a very simple modification

These two files must be loaded on the front-end --- be sure to follow
blanket.js's specifications (you must add the attribute `data-cover` to
any scripts you want blanket.js to instrument)

cucumber-blanket.js initiates a coverage report session -- you are
expected to complete the session from the Cucumber side. In this design,
we make use of Cucumber's After hook: 

```ruby
After do |scenario|
  # Grab code coverage from the frontend
  # Currently this adds >1 second to every scenario, but it's worth it
  Cucumber::Blanket.extract_from page
end
```

Of course every scenario will touch on different parts of your code, as
such Cucumber::Blanket OR's the lines. In other words, if line 10 of
File A was covered in Scenario X, but not in Scenario Y, line 10 is
considered covered when Cucumber has finished running.

Finally, to gain access to the accumulated coverage data, you can use the shorthand `Cucumber::Blanket.files`:

```ruby
after_exit do
  covdata =  # do something with it
  File.open("tmp/coverage.json", "w") do |file|
    file.write Cucumber::Blanket.files.to_json
    # writes out JSON of this form of ruby hash:
    # => {"http://127.0.0.1:32344/js/collections/assets.js"=>
    #  [3, 3, 3, nil, 3, nil, nil, nil, 0, 0, nil, 0, nil, nil, nil, nil, 0, 0]}
    # {filename=>[lineCov,lineCov,lineCov]}
    # At this stage you can fetch the files and create a nice HTML report, etc
  end
end
```

I have both of these in my `features/support/hooks.rb` file. As far as doing something useful
with the coverage data, that's left up to the user, another gem, or maybe blanket.js itself from Node.js.

## Other Features

You can use `Cucumber::Blanket.percent` to get a float value of coverage of known lines of code.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
