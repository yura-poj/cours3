# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { is_expected.to be_able_to :read, :all }

    it { is_expected.to_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { is_expected.to be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }

    it { is_expected.to_not be_able_to :manage, :all }
    it { is_expected.to be_able_to :read, :all }

    it { is_expected.to be_able_to :create, :all }

    it { is_expected.to be_able_to %i[update destroy], create(:question, author: user) }
    it { is_expected.to_not be_able_to %i[update destroy], create(:question, author: other) }

    it { is_expected.to be_able_to %i[update destroy], create(:answer, author: user) }
    it { is_expected.to_not be_able_to %i[update destroy], create(:answer, author: other) }

    it { is_expected.to be_able_to %i[update destroy], create(:link, linkable: create(:question, author: user)) }
    it { is_expected.to_not be_able_to %i[update destroy], create(:link, linkable: create(:question, author: other)) }

    it { is_expected.to be_able_to %i[update destroy], create(:reward, question: create(:question, author: user)) }
    it {
      is_expected.to_not be_able_to %i[update destroy], create(:reward, question: create(:question, author: other))
    }
  end
end
