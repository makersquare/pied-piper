class UpdateBoxStage < TransactionScript
  def run(params)
    # Updates a box stage and documents the update in the box_history table
    b = Box.find(params[:box_id])
    # binding.pry
    bh = BoxHistory.create({:box_id=>b.id, :stage_id=>params[:stage_id], :stage_from=>b.stage_id})
    b.update({b.box.stage_id=>params[:stage_id]})
    return success box: b, history: bh
  end
end
