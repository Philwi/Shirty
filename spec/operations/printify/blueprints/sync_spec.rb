# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Operations::Printify::Blueprints::Sync do
  subject { described_class.new }

  context 'when syncing' do
    it 'syncs all blueprints from printify' do
      VCR.use_cassette(subject.class.name.gsub('::', '_')) do
        expect { subject.call }.to change(::Shirty::Entities::Printify::Blueprint, :count).by(802)
      end
    end
  end
end
