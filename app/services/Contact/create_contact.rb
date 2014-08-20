require 'ostruct'

class CreateContact < TransactionScript
  def run(params)
    params = OpenStruct.new(params) if params.is_a?(Hash)
    return failure 'Contact already in database' if contact_already_exists?(params)
    return failure 'Contact is missing name' unless contact_has_name?(params)

    result = Contact.create({name: params.name, phonenumber: params.phonenumber, email: params.email})

    if result
      UserMailer.new_contact_update(result).deliver
    end

    return success(contact: result)
  end

  def contact_already_exists?(params)
    email = Contact.find_by(email: params.email)
    return false if email.nil?
    return true
  end

  def contact_has_name?(params)
    params.phonenumber = params.phonenumber if params.phonenumber.nil?
    if params.name.nil? && !params.firstname.nil?
      params.name = "#{params.firstname} #{params.lastname}"
    end
    return false if params.name.nil?
    return true
  end

end

