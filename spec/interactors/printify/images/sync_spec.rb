# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Interactors::Printify::Images::Sync do
  subject { Shirty::Interactors::Printify::Images::Sync.new }

  # before do
  #   stub_image_request
  # end

  # context 'when syncing images from printify' do
  #   context 'when no images are persisted locally' do
  #     it 'syncs image' do
  #       expect { subject.call }.to change { image_repository.all.count }.by(2)
  #     end
  #   end
  # end

  private

  def stub_image_request
    Printify::ImageFactory.new.sync
    image_repository.delete_all_images
  end

  def image_repository
    Shirty::Repositories::Printify::Images.new
  end
end
