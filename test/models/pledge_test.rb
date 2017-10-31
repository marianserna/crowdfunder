require_relative '../test_helper'

class PledgeTest < ActiveSupport::TestCase

  test 'A pledge can be created' do
    project = build(:project)
    user = build(:user)
    pledge = build(:pledge)
    pledge.save

    assert pledge.valid?
    assert pledge.persisted?
  end

  test 'owner cannot back own project' do
    project = build(:project)
    pledge = build(:pledge, project: project)
    pledge.user = project.user

    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

  test 'pledge requires dollar_amount' do
    pledge = build(:pledge, dollar_amount: nil)
    pledge.save

    assert pledge.invalid?, 'Pledge requires dollar_amount'
  end

end
