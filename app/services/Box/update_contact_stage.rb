# Updates a contact's stage based off of
# contacts hash passed in.
# Also updates the box_history table to show
# the contact's history between stages
class UpdateContactStage < TransactionScript
  def run(params)
    if params[:contact_id].nil?
      return failure(:no_contact_id_passed)
    end

    if params[:pipeline_id].nil?
      return failure(:no_pipeline_id_passed)
    end

    contact = Contact.where(id: params[:contact_id]).first
    pipeline = Pipeline.where(id: params[:pipeline_id]).first

    if contact.nil?
      return failure(:invalid_contact_id)
    end

    if pipeline.nil?
      return failure(:invalid_pipeline_id)
    end

    if params[:stage_id].nil?
      return failure(:no_stage_info_passed)
    end

    box = Box.where(contact_id: params[:contact_id]).first

    if box.nil?
      return failure(:invalid_box_id)
    end

    history = BoxHistory.create(box_id: box.id, stage_from: box.stage_id, stage_id: params[:stage_id])
    box.update(stage_id: params[:stage_id])

    return success({box: box, history: history})
  end
end
