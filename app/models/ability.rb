# frozen_string_literal: true

class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  private

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities
    can :create, :all
    can %i[destroy update], [Question, Answer], author: user
    can %i[destroy update], Link, linkable: { author: user }
    can %i[destroy update], ActiveStorage::Attachment, record: { author: user }
    can %i[destroy update], Reward, question: { author: user }
    can :set_best, Answer, question: { author: user }
  end

  def admin_abilities
    can :manage, :all
  end
end
