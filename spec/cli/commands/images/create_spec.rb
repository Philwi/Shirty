# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Cli::Commands::Images::Create do
  subject { described_class.new }

  before do
    ::Shirty::Entities::Word.create(name: 'test')
  end

  it 'creates images for words' do
    options = { all: true }

    expect { subject.call(**options) }.to change(Shirty::Entities::Image, :count).by(1)
  end

  context 'with a text color' do
    it 'creates images for word with color' do
      options = { all: true, text_color: 'white' }

      expect { subject.call(**options) }.to change(Shirty::Entities::Image, :count).by(1)
    end
  end

  context 'with invalid text color' do
    it 'creates images for word with black color' do
      options = { all: true, text_color: 'red' }

      expect { subject.call(**options) }.to change(Shirty::Entities::Image, :count).by(0)
    end
  end
end
