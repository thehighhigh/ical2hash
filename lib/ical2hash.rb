# frozen_string_literal: true

require_relative 'ical2hash/version'

module Ical2hash
  class Error < StandardError; end

  def self.convert(ics_txt)
    hash = {}
    pointer = hash
    stack = []
    ics_txt.split(/\R/).each do |r|
      next if r == ''

      key, _, value = r.partition(':')
      if key == 'BEGIN'
        stack << pointer
        pointer[value] ||= []
        pointer[value] << {}
        pointer = pointer[value][-1]
      elsif key == 'END'
        pointer = stack.pop
      else
        pointer[key] = value
      end
    end
    hash
  end

  def self.revert(ics_hash)
    pointer = ics_hash
    txt_array = []
    dig(pointer, txt_array)
    "#{txt_array.join("\r\n")}\r\n"
  end

  def self.dig(pointer, txt_array)
    pointer.each_key do |key|
      if pointer[key].is_a? Hash
        pointer = pointer[key]
        dig(pointer, txt_array)
      elsif pointer[key].is_a? Array
        pointer[key].each do |p|
          txt_array << "BEGIN:#{key}"
          dig(p, txt_array)
          txt_array << "END:#{key}"
        end
      else
        txt_array << "#{key}:#{pointer[key]}"
      end
    end
  end

  private_class_method :dig
end
