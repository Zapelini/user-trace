require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # setup do
  #   @contact = Contact.new(email: "jucabala@fulano.com" )
  # end

  teardown do
    Contact.destroy_all
    contacts = Contact.all
    assert_equal 0, contacts.count
  end

  test "should be possible to validate contact" do
    contact = Contact.new(email: "jucabala@fulano.com" )
    assert contact.valid?
  end

  test "should be possible to validate the wrong contact" do
    contact = Contact.new(email: "jucabala_fulano.com" )
    assert_not contact.valid?
  end

  test "should be possible to save a contact" do
    contact = Contact.new(email: "jucabala@fulano.com")
    assert contact.save
    # contacts = Contact.all
    # assert_equal 1, contacts.size

  end
end
