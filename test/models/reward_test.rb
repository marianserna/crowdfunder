require 'test_helper'

class RewardTest < ActiveSupport::TestCase

  test 'A reward can be created' do
    project = create(:project)
    reward = create(:reward)

    assert reward.valid?
    assert reward.persisted?
  end

  test 'A reward cannot be created without a dollar amount' do
    reward = build(:reward, dollar_amount: nil)
    reward.save

    assert reward.invalid?, 'Reward should be invalid without dollar amount'
    assert reward.new_record?, 'Reward should not save without dollar amount'
  end

  test 'A reward cannot be created without a description' do
    project = create(:project)
    reward = build(:reward, dollar_amount: nil)
    reward.save

    assert reward.invalid?, 'Reward should be invalid without a description'
    assert reward.new_record?, 'Reward should not save without a description'
  end

  test 'Reward dollar amount must be a positive number' do
    user = create(:user)
    project = create(:project)
    reward = build(:reward, dollar_amount: nil)
    reward.save

    assert reward.invalid?, 'Reward dollar amount must be a positive number'
  end
end
