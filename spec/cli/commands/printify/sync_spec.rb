# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Cli::Commands::Printify::Sync do
  subject { described_class.new }

  it 'creates images for words' do
    stub_api_requests

    expect { subject.call }
      .to change(Shirty::Entities::Printify::Blueprint, :count).by(1)
      .and change(Shirty::Entities::Printify::PrintProvider, :count).by(2)
  end

  private

  def stub_api_requests
    blueprint_factory = BlueprintFactory.new
    blueprint_factory.stub_blueprint_request
    print_provider_factory = PrintProviderFactory.new(blueprint: blueprint_factory.blueprint)
    print_provider_factory.stub_print_provider_request
  end
end
