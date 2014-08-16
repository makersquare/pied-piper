class SearchController < ApplicationController
  respond_to :json
  
  def show
    results = GetSearchResults.run({query: params[:query]})
    if results.success?
      respond_with results.search_results.to_h.as_json
    else
      respond_with results.error, status: :unprocessable_entity
    end
  end
end