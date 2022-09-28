# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Operations::Printify::PrintProviders::Sync do
  subject { described_class.new }

  context 'when syncing' do
    before do
      Printify::BlueprintFactory.new.create
      Printify::PrintProviderFactory.new.create
      ::Shirty::Entities::Printify::PrintProvider.destroy_all
    end

    it 'syncs all print providers for blueprints from printify' do
      expect { subject.call }.to change(::Shirty::Entities::Printify::PrintProvider, :count).by(2)
    end
  end
end
