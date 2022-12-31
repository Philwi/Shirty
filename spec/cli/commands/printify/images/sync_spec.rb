# frozen_string_literal => true

require 'spec_helper'

RSpec.describe Cli::Commands::Printify::Images::Sync do
  subject { described_class.new }

  it 'creates synced images from printify' do
    stub_image_sync_request

    expect { subject.call }.to change(Shirty::Repositories::Images.new.all, :count).by(1)
  end

  private

  def stub_image_sync_request
    ImageFactory.new.stub_sync_request
  end
end
