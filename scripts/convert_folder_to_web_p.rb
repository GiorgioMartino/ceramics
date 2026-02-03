class ConvertFolderToWebP
  class << self

    require "vips"

    # RUN with bundle exec ruby -r ./scripts/convert_folder_to_web_p.rb -e 'ConvertFolderToWebP.call'
    def call
      puts "Starting conversion..."

      batch_webp("assets/pieces/c2_*/*")

      puts "Done!"
    end

    def batch_webp(folder_glob, max_width: 1600, quality: 85)
      Dir.glob(folder_glob).each do |path|
        next unless path =~ /\.(jpe?g|png)\z/i
        out = to_webp_resize(path, max_width: max_width, quality: quality)
        puts "Wrote: #{out}"
      rescue => e
        warn "Failed #{path}: #{e.class}: #{e.message}"
      end
    end

    def to_webp_resize(input_path, max_width: 1600, quality: 85)
      image = Vips::Image.new_from_file(input_path, access: :sequential)

      # Resize only if wider than max_width
      if image.width > max_width
        scale = max_width.to_f / image.width
        image = image.resize(scale, kernel: :lanczos3)
      end

      out_path = input_path.sub(/\.[^.]+\z/, ".webp")

      # Q controls size/quality. "strip" removes metadata. "smart_subsample" helps for photos.
      image.webpsave(out_path,
                     Q: quality,
                     strip: true,
                     smart_subsample: true # You can also try: effort: 4..6 (higher = smaller but slower, depends on vips build)
      )

      out_path
    end

  end
end
