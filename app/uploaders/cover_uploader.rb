# frozen_string_literal: true

class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg png]
  end

  version :small do
    process resize_to_fit: [100, 300]
  end

  version :large do
    process resize_to_fit: [300, 900]
  end

  def filename
    "cover.#{file.extension}" if original_filename
  end
end
