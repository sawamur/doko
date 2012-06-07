# doko

Japanese address retriever. "doko?" means "where?" in japanese.

## Usage

```
 # from string
addrs = Doko.parse("..\n住所\n 東京都港区芝浦3-41 \n..\n...")
p addrs #=> ["東京都港区芝浦3-41"]

 # from url 
addrs = Doko.parse("http://r.tabelog.com/tokyo/A....")
p addrs #=> ["神奈川県横浜市中区.."]
```


## Install

Gemfile

```
gem 'doko',:git => 'git://github.com/sawamur/doko.git'
```

then `bundle install`

## Contributing to doko
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2012 Masaki Sawamura. See LICENSE.txt for
further details.

