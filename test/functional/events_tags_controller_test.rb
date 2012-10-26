require 'test_helper'

class EventsTagsControllerTest < ActionController::TestCase
  setup do
    @events_tag = events_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create events_tag" do
    assert_difference('EventsTag.count') do
      post :create, events_tag: @events_tag.attributes
    end

    assert_redirected_to events_tag_path(assigns(:events_tag))
  end

  test "should show events_tag" do
    get :show, id: @events_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @events_tag
    assert_response :success
  end

  test "should update events_tag" do
    put :update, id: @events_tag, events_tag: @events_tag.attributes
    assert_redirected_to events_tag_path(assigns(:events_tag))
  end

  test "should destroy events_tag" do
    assert_difference('EventsTag.count', -1) do
      delete :destroy, id: @events_tag
    end

    assert_redirected_to events_tags_path
  end
end
