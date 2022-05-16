class BookUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[pdf]
  end

  def filename
    "book.#{file.extension}" if original_filename
  end
end
