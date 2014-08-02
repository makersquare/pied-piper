class ContextioController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:callback]

  def callback
    puts params
  end
end
