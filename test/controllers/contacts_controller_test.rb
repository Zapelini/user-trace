require 'test_helper'

class ContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_url
    assert_response :success
  end

  test "should be possible create contact" do
    assert_difference('Contact.count') do
      post contacts_url, params: {contact: {email: "jucabala@fulano.com"},
                                  contacttrace: [
                                    {url: "home", date_access: "2017-07-11 06:31:13.599095"},
		                                {url: "preco", date_access: "2017-07-11 06:32:14.599095"}
                                  ]}
    end

    assert_redirected_to contact_url(Contact.last)
  end

  test "should show contact" do
    get contact_url(@contact)
    assert_response :success
  end

end
