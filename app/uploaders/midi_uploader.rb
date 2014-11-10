# encoding: utf-8

class MidiUploader < CarrierWave::Uploader::Base
  # The directory where uploaded files will be stored.
  def store_dir
    "uploads"
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # A white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(mid)
  end

  # Override the filename of the uploaded files
  def filename
    @name ||= "#{sha1}.mid" if super
  end

  def sha1
    chunk = model.send(mounted_as)
    @sha1 ||= Digest::SHA1.hexdigest(chunk.read)
  end
end
