# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Shirty::Cli::Commands::Printify do
  subject { described_class.new }

  it 'puts some stupid string' do
    expect(subject.call).to eq 'Printify the data'
  end
end
