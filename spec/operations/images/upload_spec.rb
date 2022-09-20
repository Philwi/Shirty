# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Operations::Images::Upload do
  before do
    @image_factory = ImageFactory.new
  end

  context 'upload image to printify' do
    it 'uploads image' do
      @image_factory.stub_upload_request_for_success
      image = @image_factory.create
      result = Shirty::Operations::Images::Upload.new.call(id: image.id)
      expect(result.success?).to be_truthy
      expect(result.success.height).to be(200)
    end
  end
end
