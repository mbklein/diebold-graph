module PresentationHelper

  def render_series(from)
    series = @presentations.collect { |p| p.series(from) }
    series.to_json
  end
  
end
