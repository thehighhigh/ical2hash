# Ical2hash

![RSpec](https://github.com/thehighhigh/ical2hash/actions/workflows/ci.yml/badge.svg)

Ical2hash is a Gem that can convert ics-format text into a ruby hash object.
Conversely, it also has the ability to convert from a hash object to ics format text.

## Installation

```
$ gem install ical2hash
```

## Usage

```ruby
require 'ical2hash'

ics_txt = <<"ics"
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//OpenAI//GPT-3.5//EN
CALSCALE:GREGORIAN
METHOD:PUBLISH
X-WR-CALNAME:Test Calendar

BEGIN:VEVENT
DTSTART:20230522T090000
DTEND:20230522T110000
SUMMARY:Meeting
DESCRIPTION:This is an internal meeting to discuss the progress of the project.
LOCATION:Conference Room A
END:VEVENT

BEGIN:VEVENT
DTSTART:20230526T083000
DTEND:20230526T120000
SUMMARY:External Conference
DESCRIPTION:This is a conference with industry leaders. We will discuss market trends and competitive analysis.
LOCATION:Hotel Conference Room
END:VEVENT

END:VCALENDAR
ics

Ical2hash.convert(ics_txt)

# => {
#   "VCALENDAR"=>[
#     {
#       "VERSION"=>"2.0",
#       "PRODID"=>"-//OpenAI//GPT-3.5//EN",
#       "CALSCALE"=>"GREGORIAN",
#       "METHOD"=>"PUBLISH",
#       "X-WR-CALNAME"=>"Test Calendar",
#       "VEVENT"=>[
#         {
#           "DTSTART"=>"20230522T090000",
#           "DTEND"=>"20230522T110000",
#           "SUMMARY"=>"Meeting",
#           "DESCRIPTION"=>"This is an internal meeting to discuss the progress of the project.",
#           "LOCATION"=>"Conference Room A"
#         }, 
#         {
#           "DTSTART"=>"20230526T083000",
#           "DTEND"=>"20230526T120000",
#           "SUMMARY"=>"External Conference",
#           "DESCRIPTION"=>"This is a conference with industry leaders. We will discuss market trends and competitive analysis.",
#           "LOCATION"=>"Hotel Conference Room"
#         }
#       ]
#     }
#   ]
# }

hash = {
          "VCALENDAR"=>[
            {
              "VERSION"=>"2.0",
              "PRODID"=>"-//OpenAI//GPT-3.5//EN",
              "CALSCALE"=>"GREGORIAN",
              "METHOD"=>"PUBLISH",
              "X-WR-CALNAME"=>"Test Calendar",
              "VEVENT"=>[
                {
                  "DTSTART"=>"20230522T090000",
                  "DTEND"=>"20230522T110000",
                  "SUMMARY"=>"Meeting",
                  "DESCRIPTION"=>"This is an internal meeting to discuss the progress of the project.",
                  "LOCATION"=>"Conference Room A"
                }
              ]
            }
          ]
        }

Ical2hash.revert(hash)

# => "BEGIN:VCALENDAR\r\n
# VERSION:2.0\r\n
# PRODID:-//OpenAI//GPT-3.5//EN\r\n
# CALSCALE:GREGORIAN\r\nMETHOD:PUBLISH\r\n
# X-WR-CALNAME:Test Calendar\r\n
# BEGIN:VEVENT\r\n
# DTSTART:20230522T090000\r\n
# DTEND:20230522T110000\r\n
# SUMMARY:Meeting\r\n
# DESCRIPTION:This is an internal meeting to discuss the progress of the project.\r\n
# LOCATION:Conference Room A\r\n
# END:VEVENT\r\n
# END:VCALENDAR\r\n"


ical_hash = {
  "VCALENDAR"=>[
    {
      "VERSION"=>"2.0",
      "PRODID"=>"-//OpenAI//GPT-3.5//EN",
      "CALSCALE"=>"GREGORIAN",
      "METHOD"=>"PUBLISH",
      "X-WR-CALNAME"=>"Test Calendar",
      "VEVENT"=>[
        {
          "DTSTART"=>"20230522T090000",
          "DTEND"=>"20230522T110000",
          "SUMMARY"=>"Meeting",
          "DESCRIPTION"=>"This is an internal meeting to discuss the progress of the project.",
          "LOCATION"=>"Conference Room A"
        }
      ]
    }
  ]
}

ical_hash["VCALENDAR"][0]["VEVENT"] <<  {
                                          "DTSTART"=>"20230526T083000",
                                          "DTEND"=>"20230526T120000",
                                          "SUMMARY"=>"External Conference",
                                          "DESCRIPTION"=>"This is a conference with industry leaders. We will discuss market trends and competitive analysis.",
                                          "LOCATION"=>"Hotel Conference Room"
                                        }

Ical2hash.revert(ical_hash)

#=> "BEGIN:VCALENDAR\r\n
# VERSION:2.0\r\n
# PRODID:-//OpenAI//GPT-3.5//EN\r\n
# CALSCALE:GREGORIAN\r\n
# METHOD:PUBLISH\r\n
# X-WR-CALNAME:Test Calendar\r\n
# BEGIN:VEVENT\r\n
# DTSTART:20230522T090000\r\n
# DTEND:20230522T110000\r\n
# SUMMARY:Meeting\r\n
# DESCRIPTION:This is an internal meeting to discuss the progress of the project.\r\n
# LOCATION:Conference Room A\r\n
# END:VEVENT\r\n
# BEGIN:VEVENT\r\n
# DTSTART:20230526T083000\r\n
# DTEND:20230526T120000\r\n
# SUMMARY:External Conference\r\n
# DESCRIPTION:This is a conference with industry leaders. We will discuss market trends and competitive analysis.\r\n
# LOCATION:Hotel Conference Room\r\n
# END:VEVENT\r\n
# END:VCALENDAR\r\n"

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thehighhigh/ical2hash.

## License
The gem is available as open source under the terms of the MIT License.
