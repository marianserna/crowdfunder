require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def create_project
    Project.create(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.tomorrow,
      end_date:    Date.tomorrow + 1.month,
      goal:        50000,
      user:        create_user
    )
  end

  def create_user
    User.create(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  # Using factory bot
  test "should get index" do
    category1 = create(:category)
    category2 = create(:category)

    project1 = create(:project, category: category1)
    project2 = create(:project, category: category2)

    get projects_url
    assert_response :success

    assert_equal(2, assigns(:projects).length)
  end

  test "should get search results" do
    category1 = create(:category)
    category2 = create(:category)

    project1 = create(:project, category: category1)
    project2 = create(:project, category: category2)

    get projects_url, params: { category_id: category2.id }
    assert_response :success

    # Assigns accesses the @ variable from the controller (@projects is :projects)
    assert_equal(1, assigns(:projects).length)
    # raise assigns(:projects).inspect
  end

  #
  # test "should get new" do
  #   get new_project_url
  #   assert_response :success
  # end
  #
  # test "should create project" do
  #   assert_difference('Project.count') do
  #     post projects_url, params: { project: {  } }
  #   end
  #
  #   assert_redirected_to project_url(Project.last)
  # end

  test "should show project" do
    project = create_project
    get project_url(project)

    assert_response :success
  end

  # test "should get edit" do
  #   get edit_project_url(@project)
  #   assert_response :success
  # end
  #
  # test "should update project" do
  #   patch project_url(@project), params: { project: {  } }
  #   assert_redirected_to project_url(@project)
  # end
  #
  # test "should destroy project" do
  #   assert_difference('Project.count', -1) do
  #     delete project_url(@project)
  #   end
  #
  #   assert_redirected_to projects_url
  # end
end
