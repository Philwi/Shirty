# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Operations::Printify::Blueprints::Sync do
  subject { described_class.new }

  context 'when syncing' do
    it 'syncs all blueprints from printify' do
      allow_any_instance_of(Shirty::Http::Printify::Blueprints).to receive(:all).and_return(
        [
          {
            'id': 3,
            'title': 'Kids Regular Fit Tee',
            'description': 'blabla',
            'brand': 'Delta',
            'model': '11736',
            'images': [
              'https:\/\/images.printify.com\/5853fe7dce46f30f8327f5cd',
              'https:\/\/images.printify.com\/5c487ee2a342bc9b8b2fc4d2'
            ]
          }
        ]
      )

      expect { subject.call }.to change(::Shirty::Entities::Printify::Blueprint, :count).by(1)
    end
  end
end
