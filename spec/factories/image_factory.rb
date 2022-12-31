class ImageFactory < AbstractFactory
  private

  attr_reader :word, :shop

  public

  attr_reader :image

  def initialize(word: WordFactory.new, shop: ::ShopFactory.new.create)
    @word = word.create
    @shop = shop
  end

  def create
    stub_upload_request_for_success

    @image =
      ::Shirty::Interactors::Images::ImageService.new.create_from_word(
        word:,
        color: 'black',
        shop:
      ).success
  end

  def sync
    stub_sync_request

    ::Shirty::Interactors::Images::ImageService.new.sync
  end

  def stub_sync_request
    allow_any_instance_of(Shirty::Http::Printify::Images).to receive(:all).and_return(success_response)
  end

  private

  def stub_upload_request_for_success
    allow_any_instance_of(
      Shirty::Http::Printify::Images
    ).to receive(:create).and_return(success_attributes)
  end

  def success_attributes
    {
      'id' => '632f4ab1dfd69200015adce8',
      'file_name' => 'I Hate_Foo_black.png',
      'height' => 200,
      'width' => 400,
      'size' => 4455,
      'mime_type' => 'image/png',
      'preview_url' => 'https://pfy-prod-image-storage.s3.us-east-2.amazonaws.com/10042838/7778643c-41e0-44f2-a19c-9b70d6b259d4',
      'upload_time' => '2022-09-24 18:21:37'
    }
  end

  def success_response
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
          'preview_url' => 'https =>//example.com/image-storage/uuid1',
          'upload_time' => '2020-01-09 07 =>29 =>43'
        }
      ],
      'first_page_url' => '/?page=1',
      'from' => 1,
      'last_page' => 2,
      'last_page_url' => '/?page=2',
      'next_page_url' => '/?page=2',
      'path' => '/',
      'per_page' => 1,
      'prev_page_url' => nil,
      'to' => 2,
      'total' => 2
    }
  end
end
