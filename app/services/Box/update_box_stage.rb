class UpdateBoxStage < TransactionScript
  def run(params)
    # Updates a box stage and documents the update in the box_histories table
    b = Box.find(params[:box_id])
    bh = BoxHistory.create({:box_id=>b.id, :stage_id=>params[:stage_id], :stage_from=>b.stage_id})
    b.update({:stage_id=>params[:stage_id]})
    return success box: b, history: bh
  end
end
