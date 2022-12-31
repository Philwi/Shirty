# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Cli::Commands::Printify::External::Sync do
  subject { described_class.new }

  it 'creates images for words' do
    create_state

    expect { subject.call }
      .to change(Shirty::Repositories::Printify::Blueprints.new.all, :count)
      .by(1)
      .and change(Shirty::Repositories::Printify::PrintProviders.new.all, :count)
      .by(2)
      .and change(Shirty::Repositories::Printify::Variants.new.all, :count)
      .by(1)
  end

  private

  def create_state
    blueprint = Printify::BlueprintFactory.new.create
    print_provider = Printify::PrintProviderFactory.new(blueprint:).create
    Printify::VariantFactory.new(blueprint:, print_provider:).create
    # to test the syncing. otherwhise it would, because it is already existing
    Shirty::Repositories::Printify::Variants.new.delete_all_variants
  end
end
