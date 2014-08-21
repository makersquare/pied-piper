# Updates a contact's notes based off of
# notes hash passed in.
class UpdateContactNote < TransactionScript
  def run(params)

    if params[:note].nil?
      return failure(:no_note_info_passed)
    end

    note = Note.where(id: params[:note][:id]).first

    if note.nil?
      return failure(:invalid_note_id)
    end

    note.update(params[:note])

    return success({note: note})
  end
end
