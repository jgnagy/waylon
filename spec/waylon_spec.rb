# frozen_string_literal: true

RSpec.describe Waylon do
  it "has a version number" do
    expect(Waylon::Core::VERSION).not_to be nil
  end
end
