# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Operations::Printify::Blueprints::Sync do
  subject { described_class.new }

  context 'when syncing' do
    it 'syncs all blueprints from printify' do
      BlueprintFactory.new.stub_blueprint_request

      expect { subject.call }.to change(::Shirty::Entities::Printify::Blueprint, :count).by(1)
    end
  end
end
