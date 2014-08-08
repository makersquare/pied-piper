class NotesController < ApplicationController
  respond_to :json
  # before_filter :logged_in?
  # before_filter :admin?

  def create
    # binding.pry
    # Create a new note
    results = CreateNote.run(notes_params)
    if results.success?
      respond_with results.pipeline, results.contact, results.data
    else
      respond_with results.error
    end
  end

  def destroy
    # Delete the note
    respond_with Note.destroy(params['id']).to_json
  end

  def index
    respond_with Note.where(box_id: params["box_id"]).to_json
  end

  private

  def notes_params
    params.permit(:notes, :id, :box_id, :user_id, :pipeline_id, :contact_id, :format)
  end
end