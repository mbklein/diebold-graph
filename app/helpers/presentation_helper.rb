module PresentationHelper
  
  def render_series_data
    raw(series_data.to_json)
  end
  
  def series_data
    series = @presentations.collect { |p| p.series(@by) }
    if params[:top]
      cutoff = params[:top].to_i-1
      while cutoff < series.length-1 and series[cutoff][:data].last.last == series[cutoff+1][:data].last.last
        cutoff += 1
      end
      series = series[0..cutoff]
    end
    series
  end
  
end
