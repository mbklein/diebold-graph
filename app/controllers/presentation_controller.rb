class PresentationController < ApplicationController

  def view
    @by = params[:by] ? params[:by].to_sym : :score
    @presentations = Presentation.find_all_by_election_id params[:id]
    @presentations.sort! { |a,b| b.snapshots.last.send(@by) <=> a.snapshots.last.send(@by) }
    respond_to do |format|
      format.html 
      format.json { 
        render :json => @presentations.collect { |p| p.series }.to_json 
      }
    end
  end

  def update
    Presentation.snapshot params[:id]
    render :text => '', :status => 200
  end
  
end
