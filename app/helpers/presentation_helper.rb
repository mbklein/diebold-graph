module PresentationHelper
  
  def render_series_data
    series = @presentations.collect { |p| p.series(@by) }
    if params[:top]
      series = series[0..params[:top].to_i-1]
    end
    raw(series.to_json)
  end
  
end
