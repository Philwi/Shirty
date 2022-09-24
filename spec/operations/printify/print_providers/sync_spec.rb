# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Operations::Printify::PrintProviders::Sync do
  subject { described_class.new }

  context 'when syncing' do
    before do
      blueprint_factory = BlueprintFactory.new
      blueprint_factory.create_blueprint
      blueprint_factory.stub_blueprint_request
      PrintProviderFactory.new.stub_print_provider_request
    end

    it 'syncs all print providers for blueprints from printify' do
      expect { subject.call }.to change(::Shirty::Entities::Printify::PrintProvider, :count).by(2)
    end
  end
end
