# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Interactors::Printify::Blueprints::Sync do
  subject { described_class.new }

  context 'when syncing' do
    it 'syncs all blueprints from printify' do
      Printify::BlueprintFactory.new.create

      expect { subject.call }.to change(::Shirty::Repositories::Printify::Blueprints.new.all, :count).by(1)
    end
  end
end
