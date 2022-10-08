module Printify
  class ImageFactory < ::AbstractFactory
    private

    attr_reader :image

    public

    def initialize(image: ::ImageFactory.new.create)
      @image = image
    end

    def create
      stub_upload
      Shirty::Interactors::Printify::Images::Upload.new.call(id: image.id)
    end

    private

    def stub_upload(image_attributes: default_image_attributes)
      allow_any_instance_of(::Shirty::Http::Printify::Images).to receive(:create).and_return(image_attributes)
    end

    def default_image_attributes
      {
        'id' => '5941187eb8e7e37b3f0e62e5',
        'file_name' => 'image.png',
        'height' => 200,
        'width' => 400,
        'size' => 1021,
        'mime_type' => 'image/png',
        'preview_url' => 'https://example.com/image-storage/uuid3',
        'upload_time' => '2020-01-09 07:29:43'
      }
    end
  end
end
