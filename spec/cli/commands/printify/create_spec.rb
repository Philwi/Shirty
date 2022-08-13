# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Cli::Commands::Printify::Create do
  subject { described_class.new }

  it 'puts some stupid string' do
    expect(subject.call).to eq 'Creates the data'
  end
end
