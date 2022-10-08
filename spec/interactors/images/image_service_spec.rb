# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Interactors::Images::ImageService do
  before do
    ::Shirty::Repositories::Words.new.create_word_by_name('test')
  end

  let(:word) { ::Shirty::Repositories::Words.new.last_created_word }
  let(:shop) { ::ShopFactory.new.create }
  let(:color) { 'white' }

  context 'when calling create from word' do
    subject { described_class.new.create_from_word(word: word, color: color, shop: shop) }

    context 'text color' do
      it 'create image for word with color' do
        expect(subject.success?).to be_truthy
      end

      context 'with invalid text color' do
        let(:color) { 'red' }

        it 'creates images for word with black color' do
          expect(subject.failure).to eq(:color_not_valid)
        end
      end
    end

    context 'shop' do
      it 'creates images for word with shop' do
        expect(subject.success?).to be_truthy
      end

      context 'with invalid shop' do
        let(:shop) { nil }

        it 'creates images for word with shop' do
          expect(subject.failure).to eq(:shop_not_valid)
        end
      end
    end

    context 'word' do
      it 'creates images for word' do
        expect(subject.success?).to be_truthy
      end

      context 'with invalid word' do
        let(:word) { nil }

        it 'creates images for word' do
          expect(subject.failure).to eq(:word_not_given)
        end
      end
    end
  end

  # context 'when create image from file name' do
  #   subject { ::Shirty::Interactors::Images::ImageService.new }

  #   it 'creates image' do
  #     expect { subject.create_from_file_name('I Hate_wurst_black.png') }.to change { image_repository.all.count }.by(1)
  #   end
  # end

  private

  def image_repository
    ::Shirty::Repositories::Images.new
  end
end
