class PresentationController < ApplicationController

  def view
    @presentations = Presentation.find_all_by_election_id params[:id]
    respond_to do |format|
      format.html 
      format.json { 
        render :json => @presentations.collect { |p| p.series }.to_json 
      }
    end
  end

  def update
    Presentation.snapshot params[:id]
    render :text => 'OK', :status => 200
  end
  
end
