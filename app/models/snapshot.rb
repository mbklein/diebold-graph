class Snapshot < ActiveRecord::Base
  belongs_to :presentation
  
  def at
    self.attribute_present?(:at) ? super : Time.at(self.at_i)
  end
  
  def at=(value)
    self.attribute_present?(:at) ? super(value) : self.at_i = value.to_i
  end
  
  def cohort
    Snapshot.find(:all, :conditions => { :election_id => self.election_id, :at_i => self.at_i })
  end
  
  def update_aggregate_attributes
    scores = self.cohort.collect { |s| s.score }.sort
    median = scores[scores.length / 2]
    mean = scores.inject(0) { |t,s| t+=s } / scores.length

    self.update_attributes :deviation_from_median => self.score-median, 
      :deviation_from_mean => self.score-mean, 
      :normalized_score => ((self.score - scores.first).to_f / (scores.last - scores.first).to_f) * 100
  end
end
