# frozen_string_literal => true

require 'spec_helper'

RSpec.describe ::Cli::Commands::Setup do
  subject { described_class.new(word_list: ['hey']) }

  before do
    stub_requests
  end

  it 'creates all words, images and uploads images and sync printify stuff' do
    expect { subject.call }
      .to change(::Shirty::Repositories::Words.new.all_words, :count).by(1)
      .and change(::Shirty::Repositories::Images.new.all, :count).by(1)
      .and change(::Shirty::Entities::Printify::Blueprint, :count).by(1)
      .and change(::Shirty::Entities::Printify::PrintProvider, :count).by(2)
      .and change(::Shirty::Entities::Printify::Variant, :count).by(1)
      .and change(::Shirty::Entities::Printify::Image, :count).by(2) # Word Factory creates another word
  end

  private

  def stub_requests
    blueprint = Printify::BlueprintFactory.new.create
    print_provider = Printify::PrintProviderFactory.new(blueprint: blueprint).create
    Printify::VariantFactory.new(blueprint: blueprint, print_provider: print_provider).create
    # to test the syncing. otherwhise it would, because it is already existing
    Shirty::Entities::Printify::Variant.destroy_all
    Printify::ImageFactory.new.create
  end
end
