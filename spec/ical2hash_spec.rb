# frozen_string_literal: true

require 'ical2hash'

RSpec.describe Ical2hash do
  context 'ical to hash' do
    let(:ics) do
      File.open('spec/test_data/ics01.txt', &:read)
    end

    it 'convert' do
      expect(Ical2hash.convert(ics)).to eql(
        {
          'VCALENDAR' => [
            {
              'CALSCALE' => 'GREGORIAN',
              'METHOD' => 'PUBLISH',
              'PRODID' => '-//ical2hash',
              'VERSION' => '2.0',
              'X-WR-CALNAME' => 'Test Calendar',
              'VEVENT' => [
                {
                  'DESCRIPTION' => 'description',
                  'DTEND' => '20230522T110000',
                  'DTSTART' => '20230522T090000',
                  'LOCATION' => 'location',
                  'SUMMARY' => 'summary'
                },
                {
                  'DESCRIPTION' => 'description',
                  'DTEND' => '20230522T110000',
                  'DTSTART' => '20230522T090000',
                  'LOCATION' => 'location',
                  'SUMMARY' => 'summary'
                },
                {
                  'DESCRIPTION' => 'description',
                  'DTEND' => '20230522T110000',
                  'DTSTART' => '20230522T090000',
                  'LOCATION' => 'location',
                  'SUMMARY' => 'summary'
                }
              ]
            }
          ]
        }
      )
    end
  end

  context 'hash to ical' do
    let(:hash) do
      {
        'VCALENDAR' => [
          {
            'VERSION' => '2.0',
            'PRODID' => '-//ical2hash',
            'CALSCALE' => 'GREGORIAN',
            'METHOD' => 'PUBLISH',
            'X-WR-CALNAME' => 'Test Calendar',
            'VEVENT' => [
              {
                'DTSTART' => '20230522T090000',
                'DTEND' => '20230522T110000',
                'SUMMARY' => 'summary',
                'DESCRIPTION' => 'description',
                'LOCATION' => 'location'
              },
              {
                'DTSTART' => '20230522T090000',
                'DTEND' => '20230522T110000',
                'SUMMARY' => 'summary',
                'DESCRIPTION' => 'description',
                'LOCATION' => 'location'
              },
              {
                'DTSTART' => '20230522T090000',
                'DTEND' => '20230522T110000',
                'SUMMARY' => 'summary',
                'DESCRIPTION' => 'description',
                'LOCATION' => 'location'
              }
            ]
          }
        ]
      }
    end

    it 'revert' do
      expect(Ical2hash.revert(hash).split(/\R/)).to eql(File.open('spec/test_data/ics01.txt', &:read).split(/\R/))
    end
  end

  context 'insert ical' do
    let(:hash) do
      {
        'VCALENDAR' => [
          {
            'VERSION' => '2.0',
            'PRODID' => '-//ical2hash',
            'CALSCALE' => 'GREGORIAN',
            'METHOD' => 'PUBLISH',
            'X-WR-CALNAME' => 'Test Calendar',
            'VEVENT' => [
              {
                'DTSTART' => '20230522T090000',
                'DTEND' => '20230522T110000',
                'SUMMARY' => 'summary',
                'DESCRIPTION' => 'description',
                'LOCATION' => 'location'
              },
              {
                'DTSTART' => '20230522T090000',
                'DTEND' => '20230522T110000',
                'SUMMARY' => 'summary',
                'DESCRIPTION' => 'description',
                'LOCATION' => 'location'
              }
            ]
          }
        ]
      }
    end

    it 'insert' do
      hash['VCALENDAR'][0]['VEVENT'] << { 'DTSTART' => '20230522T090000', 'DTEND' => '20230522T110000',
                                          'SUMMARY' => 'summary', 'DESCRIPTION' => 'description', 'LOCATION' => 'location' }
      expect(Ical2hash.revert(hash).split(/\R/)).to eql(File.open('spec/test_data/ics01.txt', &:read).split(/\R/))
    end
  end
end
