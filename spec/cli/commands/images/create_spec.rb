# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Cli::Commands::Images::Create do
  subject { described_class.new }

  it 'creates images for words' do
    options = { all: true }
    ::Shirty::Entities::Word.create(name: 'test')

    expect { subject.call(**options) }.to change(Shirty::Entities::Image, :count).by(1)
  end
end
