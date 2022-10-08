# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Interactors::Images::Create do
  before do
    ::Shirty::Repositories::Words.new.create_word_by_name('test')
  end

  let(:word) { ::Shirty::Repositories::Words.new.last_created_word }
  let(:shop) { ::Shirty::Entities::Shops::IHateEverything }
  let(:color) { 'white' }

  subject { described_class.new.call(word: word, color: color, shop: shop) }

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
        expect(subject.failure).to eq(:shop_not_given)
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
