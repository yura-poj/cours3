# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to :linkable }
end
