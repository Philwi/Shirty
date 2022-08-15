# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Operations::Printify::PrintProviders::Sync do
  subject { described_class.new }

  context 'when syncing' do
    before do
      ::Shirty::Entities::Printify::Blueprint.create(
        printify_id: '3',
        title: 'Blueprint 1',
        brand: 'Brand 1',
        model: 'Model 1',
        images: ['image1.jpg', 'image2.jpg'],
        description: 'Description 1'
      )
    end

    it 'syncs all print providers for blueprints from printify' do
      VCR.use_cassette(subject.class.name.gsub('::', '_')) do
        expect { subject.call }.to change(::Shirty::Entities::Printify::PrintProvider, :count).by(2)
      end
    end
  end
end
