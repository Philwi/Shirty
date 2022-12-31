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

    def sync
      stub_sync
      Shirty::Interactors::Printify::Images::Sync.new.call
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

    def stub_sync(response_image_attributes: default_response_image_attributes)
      allow_any_instance_of(::Shirty::Http::Printify::Images).to receive(:all).and_return(response_image_attributes)
    end

    def default_response_image_attributes
      {
        'current_page' => 1,
        'data' => [
          {
            'id' => '5e16d66791287a0006e522b2',
            'file_name' => 'I Hate_Foo_black.png',
            'height' => 5979,
            'width' => 17_045,
            'size' => 1_138_575,
            'mime_type' => 'image/png',
            'preview_url' => 'https://example.com/image-storage/uuid1',
            'upload_time' => '2020-01-09 07:29:43'
          },
          {
            'id' => '5de50bf612c348000892b366',
            'file_name' => 'I Hate_Foo_black.png',
            'height' => 360,
            'width' => 360,
            'size' => 19_589,
            'mime_type' => 'image/jpeg',
            'preview_url' => 'https://example.com/image-storage/uuid2',
            'upload_time' => '2019-12-02 13:04:54'
          }
        ],
        'first_page_url' => '/?page=1',
        'from' => 1,
        'last_page' => 1,
        'last_page_url' => '/?page=1',
        'next_page_url' => nil,
        'path' => '/',
        'per_page' => 10,
        'prev_page_url' => nil,
        'to' => 2,
        'total' => 2
      }
    end
  end
end
