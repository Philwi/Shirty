# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cli::Commands::Images::Create do
  subject { described_class.new }

  before do
    Shirty::Repositories::Words.new.create_word_by_name('test')
    ShopFactory.new.create
  end

  it 'creates images for words' do
    options = { all: true }

    expect { subject.call(**options) }.to change(image_repository.all, :count).by(1)
  end

  context 'with a text color' do
    it 'creates images for word with color' do
      options = { all: true, text_color: 'white' }

      expect { subject.call(**options) }.to change(image_repository.all, :count).by(1)
    end
  end

  context 'with invalid text color' do
    it 'creates images for word with black color' do
      options = { all: true, text_color: 'red' }

      expect { subject.call(**options) }.to change(image_repository.all, :count).by(0)
    end
  end

  context 'with shop' do
    it 'creates images for word with shop' do
      # TODO: shop should not be a entity?
      options = { all: true, text_color: 'white', shop: ShopFactory.new.create }

      expect { subject.call(**options) }.to change(image_repository.all, :count).by(1)
      expect(Shirty::Entities::Image.last.shop).to eq(Shirty::Repositories::Shops.new.last_created_shop)
    end
  end

  private

  def image_repository
    Shirty::Repositories::Images.new
  end
end
