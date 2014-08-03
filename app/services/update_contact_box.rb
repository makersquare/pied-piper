# class UpdateContactBox < TransactionScript
#   def run(params)
#     # Updates a contact's box info
#     binding.pry
#     b = Box.find(params[:box_id]).update(params)
#     c = Contact.find(params[:contact_id]).update(params)
#     f = Field.find(params[:field_id]).update(params)
#     fv = BoxField.find(params[:box_field_id]).update(params)
#     n = Notes.find(params[:note_id]).update(params)
#     return success box: b, contact: c, field: f, field_value: fv, notes: n
#   end
# end
