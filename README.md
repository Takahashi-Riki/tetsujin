# Tetsujin

## Installation

```
$ gem install tetsujin
```

## Usage

### Please include Tetsujin Module

```ruby
require "tetsujin"

class YourClass
  include Tetsujin
end
```

### Generate a Note

```ruby
# Can generate C4 sound
c_note = create_note("C", 4)
c_note = create_note("ド", 4)
```

### Generate a Scale

```ruby
# Can generate major scales starting from C4
c_note = create_note("C", 4)
c_major_scale = create_scale(c_note, :major)
c_major_scale = create_scale(c_note, "major")
```

### Generate a Guitar

```ruby
# Can generate a guitar in regular tuning
guitar = create_regular_tuning_guitar(fretboard_length: 22)

# Can generate custom tuned guitars
tunings = [
  create_note("B", 2),
  create_note("E", 2),
  create_note("A", 2),
  create_note("D", 3),
  create_note("G", 3),
  create_note("B", 3),
  create_note("E", 4)
]
guitar = create_guitar(tunings: tunings, fretboard_length: 22)
```

### Playing notes on the guitar

```ruby
guitar = create_regular_tuning_guitar(fretboard_length: 12)

c_note = create_note("C", 4)
d_note = create_note("D", 4)

guitar.play!([c_note, d_note])
display_guitar(guitar)

#  1 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#  2 : -------      C4 -------      D4 ------- ------- ------- ------- ------- ------- ------- ------- -------
#  3 : ------- ------- ------- ------- -------      C4 -------      D4 ------- ------- ------- ------- -------
#  4 : ------- ------- ------- ------- ------- ------- ------- ------- ------- -------      C4 -------      D4
#  5 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#  6 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#    :       0       1       2       3       4       5       6       7       8       9      10      11      12
```

### Playing scales on the guitar

```ruby
guitar = create_regular_tuning_guitar(fretboard_length: 12)

c_note = create_note("C", 4)
c_major_scale = create_scale(c_note, :major)

guitar.play!(c_major_scale)
create_display_guitar(guitar)

#  1 :      E4      F4 -------      G4 -------      A4 -------      B4      C5 ------- ------- ------- -------
#  2 : -------      C4 -------      D4 -------      E4      F4 -------      G4 -------      A4 -------      B4
#  3 : ------- ------- ------- ------- -------      C4 -------      D4 -------      E4      F4 -------      G4
#  4 : ------- ------- ------- ------- ------- ------- ------- ------- ------- -------      C4 -------      D4
#  5 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#  6 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#    :       0       1       2       3       4       5       6       7       8       9      10      11      12
```

### Pressing frets

```ruby
guitar = create_regular_tuning_guitar(fretboard_length: 12)

guitar.press!(2, 1)
guitar.press!(2, 3)
display_guitar(guitar)

#  1 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#  2 : -------      C4 -------      D4 ------- ------- ------- ------- ------- ------- ------- ------- -------
#  3 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#  4 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#  5 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#  6 : ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- ------- -------
#    :       0       1       2       3       4       5       6       7       8       9      10      11      12
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tetsujin.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
