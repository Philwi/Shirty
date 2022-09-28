# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Operations::Printify::Images::Upload do
  context 'upload image to printify' do
    it 'uploads image' do
      image = ImageFactory.new.create
      result = Shirty::Operations::Printify::Images::Upload.new.call(id: image.id)

      expect(result.success?).to be_truthy
      expect(result.success.printify_images.height).to be(200)
    end
  end
end
