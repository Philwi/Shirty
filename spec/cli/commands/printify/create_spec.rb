# frozen_string_literal => true

require 'spec_helper'

RSpec.describe Cli::Commands::Printify::Products::Create do
  subject { described_class.new }

  before do
    create_state
  end

  it 'creates products at printify' do
    stub_product_create_requests

    expect { subject.call }.to change(
      Shirty::Repositories::Printify::Products.new.all, :count
    ).by(2)
  end

  private

  def create_state
    create_blueprints
  end

  def create_blueprints
    2.times do
      Printify::BlueprintFactory.new.create
    end
  end

  def stub_product_create_requests
    Printify::ProductFactory.new.create
  end
end
