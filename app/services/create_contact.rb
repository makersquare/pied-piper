require 'ostruct'

class CreateContact < TransactionScript
  def run(params)
    params = OpenStruct.new(params) if params.is_a?(Hash)
    return failure 'Contact already in database' if contact_already_exists?(params)
    return failure 'Contact is missing name' unless contact_has_name?(params)

    result = Contact.create({name: params.name, phoneNum: params.phoneNum, email: params.email})
    return success(contact: result)
  end

  def contact_already_exists?(params)
    email = Contact.find_by(email: params.email)
    name = Contact.find_by(name: params.name)
    name = Contact.find_by(name:'#{params.firstname} #{params.lastname}') if name.nil?
    if !name.nil? && !email.nil?
      return true
    end

  end

  def contact_has_name?(params)
    params.phoneNum = params.phonenumber if params.phoneNum.nil?
    params.name = '#{params.firstname} #{params.lastname}' if params.name.nil?
    return false if params.name.nil?
    return true
  end


end
