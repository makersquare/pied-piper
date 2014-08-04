class GetContactBox < TransactionScript
#   def run(params)
#     # Returns a contact's box, with info associated with the pipeline stage
#     b = Box.where('contact_id = ?', params[:contact_id])
#     c = Box.find(b.first.id).contact
#     f = Box.find(b.first.id).fields
#     fv = Box.find(b.first.id).box_fields
#     n = Box.find(b.first.id).notes
#     return success box: b, contact: c, field: f, field_value: fv, notes: n
#   end
end
