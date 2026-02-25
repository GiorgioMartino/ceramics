#!/usr/bin/env ruby
# frozen_string_literal: true

# Usage:
#   bundle exec ruby scripts/create_piece_md_files.rb 3
#
# For collection N, scans:
#   assets/pieces/cN_p*
# and creates (if missing):
#   _pieces/cN_pX.md
#
# In each md file, under `images:`, it adds all .webp files found in that folder.

require "fileutils"

collection_str = ARGV[0]

unless collection_str
  warn "Usage: bundle exec ruby scripts/create_piece_md_files.rb <collection_number>"
  exit 1
end

collection = Integer(collection_str, 10)
if collection <= 0
  warn "<collection_number> must be a positive integer."
  exit 1
end

project_root = File.expand_path(File.join(__dir__, ".."))
assets_pieces_dir = File.join(project_root, "assets", "pieces")
pieces_md_dir = File.join(project_root, "_pieces")

unless Dir.exist?(assets_pieces_dir)
  warn "Could not find assets/pieces directory at: #{assets_pieces_dir}"
  exit 1
end

FileUtils.mkdir_p(pieces_md_dir)

dir_regex = /\Ac#{collection}_p(\d+)\z/

piece_dirs =
  Dir.children(assets_pieces_dir)
     .select { |name| File.directory?(File.join(assets_pieces_dir, name)) }
     .select { |name| name.match?(dir_regex) }
     .sort_by { |name| name.match(dir_regex)[1].to_i }

template_header = <<~MD
  ---
  title: ""
  year: 2026
  dimensions:
    width:
    height:
  materials: "Earthenware"
  status: "available"

  categories:
    -

  featured: false

  price:


  images:
MD

template_footer = <<~MD

  ---
  Body: Red clay earthenware bisque fired at 980C

  Glaze: Fired at 1020C.<br>
MD

created = []
skipped_existing = []
missing_images = []

piece_dirs.each do |dir_name|
  md_path = File.join(pieces_md_dir, "#{dir_name}.md")

  if File.exist?(md_path)
    skipped_existing << "#{dir_name}.md"
    next
  end

  images_dir = File.join(assets_pieces_dir, dir_name)
  webps =
    Dir.children(images_dir)
       .select { |fn| fn.downcase.end_with?(".webp") }
       .sort

  if webps.empty?
    missing_images << dir_name
  end

  images_lines =
    webps.map do |fn|
      "  - /assets/pieces/#{dir_name}/#{fn}"
    end.join("\n")

  content = +""
  content << template_header
  content << (images_lines.empty? ? "  -\n" : "#{images_lines}\n")
  content << template_footer

  File.write(md_path, content)
  created << "#{dir_name}.md"
end

puts "Collection: #{collection}"
puts "Assets base: #{assets_pieces_dir}"
puts "MD output:   #{pieces_md_dir}"
puts

puts "Created (#{created.size}): #{created.join(', ')}" unless created.empty?
puts "Skipped existing (#{skipped_existing.size}): #{skipped_existing.join(', ')}" unless skipped_existing.empty?
puts "Folders with no .webp images (#{missing_images.size}): #{missing_images.join(', ')}" unless missing_images.empty?