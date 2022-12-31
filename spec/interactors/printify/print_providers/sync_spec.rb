# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Interactors::Printify::PrintProviders::Sync do
  subject { described_class.new }

  context 'when syncing' do
    before do
      Printify::BlueprintFactory.new.create
      Printify::PrintProviderFactory.new.create
      print_provider_repository.delete_all_providers
    end

    it 'syncs all print providers for blueprints from printify' do
      expect { subject.call }.to change(print_provider_repository.all, :count).by(2)
    end

    private

    def print_provider_repository
      Shirty::Repositories::Printify::PrintProviders.new
    end
  end
end
