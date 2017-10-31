require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest

  # Refactoring to use factory bot
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

  test "should show project" do
    project = create(:project)
    get project_url(project)

    assert_response :success
  end
end
