require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  test 'user sign in and registration forms render' do
    get new_user_session_path
    assert_response :success
    assert_select 'input[name="user[email]"]'
    get new_user_registration_path
    assert_response :success
  end

  test 'confirmed user can sign in and sign out' do
    post user_session_path, params: { user: { email: users(:one).email, password: 'test-password-123' } }
    assert_redirected_to root_path
    delete destroy_user_session_path
    assert_redirected_to root_path
  end

  test 'registration persists confirmation state without sending real mail' do
    assert_difference('User.count', 1) do
      post user_registration_path, params: { user: { email: 'new-user@example.org', password: 'test-password-123', password_confirmation: 'test-password-123' } }
    end
    assert_response :redirect
    assert_not User.find_by!(email: 'new-user@example.org').confirmed?
  end

  test 'a normal user cannot access the admin area' do
    post user_session_path, params: { user: { email: users(:one).email, password: 'test-password-123' } }
    get '/admin'
    assert_redirected_to new_admin_session_path
  end

  test 'admin area requires admin authentication' do
    get '/admin'
    assert_redirected_to new_admin_session_path
  end

  test 'admin can import contribution rates from CSV' do
    post admin_session_path, params: { admin: { email: admins(:one).email, password: 'test-password-123' } }
    assert_difference('TaxReference.count', 1) do
      post '/admin/tax_reference/import', params: { file: fixture_file_upload('tax_references.csv', 'text/csv'), encoding: 'UTF-8' }
    end
    assert_response :success
    assert_in_delta 417.0, TaxReference.find_by!(year: 2027).total_contribution(100), 0.000001
  end

  test 'admin can sign in view dashboard and use tax reference import form' do
    post admin_session_path, params: { admin: { email: admins(:one).email, password: 'test-password-123' } }
    assert_redirected_to root_path
    get '/admin'
    assert_response :success
    get '/admin/tax_reference'
    assert_response :success
    get '/admin/tax_reference/import'
    assert_response :success
    assert_select 'input[type="file"]'
  end
end
