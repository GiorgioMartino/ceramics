#!/usr/bin/env ruby
# frozen_string_literal: true

# Usage:
#   bundle exec ruby scripts/create_pieces_dirs.rb 3 7
#
# Creates:
#   assets/pieces/c3_p1
#   assets/pieces/c3_p2
#   ...
#   assets/pieces/c3_p7

require "fileutils"

collection_str, pieces_str = ARGV

unless collection_str && pieces_str
  warn "Usage: bundle exec ruby scripts/create_pieces_dirs.rb <collection_number> <pieces_count>"
  exit 1
end

collection = Integer(collection_str, 10)
pieces_count = Integer(pieces_str, 10)

if collection <= 0 || pieces_count <= 0
  warn "Both <collection_number> and <pieces_count> must be positive integers."
  exit 1
end

base_dir = File.join(__dir__, "..", "assets", "pieces")

created = []
skipped = []

1.upto(pieces_count) do |i|
  dir_name = "c#{collection}_p#{i}"
  dir_path = File.join(base_dir, dir_name)

  if Dir.exist?(dir_path)
    skipped << dir_name
    next
  end

  FileUtils.mkdir_p(dir_path)
  created << dir_name
end

puts "Base: #{File.expand_path(base_dir)}"
puts "Created (#{created.size}): #{created.join(', ')}" unless created.empty?
puts "Already existed (#{skipped.size}): #{skipped.join(', ')}" unless skipped.empty?