require 'test_helper'

class TaxReferencesControllerTest < ActionDispatch::IntegrationTest
  test 'lists references and renders the full contribution table' do
    get '/tax_references'
    assert_response :success
    assert_select 'a[href="/tax_references/2026"]'
    get '/tax_references/2026'
    assert_response :success
    assert_select 'table tbody tr', count: 172
    assert_select 'table tbody tr:first-child td', text: '1'
  end
end
