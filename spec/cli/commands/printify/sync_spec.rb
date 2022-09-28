# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Cli::Commands::Printify::Sync do
  subject { described_class.new }

  it 'creates images for words' do
    create_state

    expect { subject.call }
      .to change(
        Shirty::Entities::Printify::Blueprint, :count
      ).by(1)
      .and change(
        Shirty::Entities::Printify::PrintProvider, :count
      ).by(2)
      .and change(
        Shirty::Entities::Printify::Variant, :count
      ).by(1)
  end

  private

  def create_state
    blueprint = Printify::BlueprintFactory.new.create
    print_provider = Printify::PrintProviderFactory.new(blueprint: blueprint).create
    Printify::VariantFactory.new(blueprint: blueprint, print_provider: print_provider).create
    # to test the syncing. otherwhise it would, because it is already existing
    Shirty::Entities::Printify::Variant.destroy_all
  end
end
