class Presentation < ActiveRecord::Base
  has_many :snapshots

  @@client = RestClient::Resource.new("http://vote.code4lib.org/election/results/")
  def self.snapshot(election_id)
    results = JSON.parse(@@client[election_id].get({:accept => :json}))
    results.each do |result|
      pres = Presentation.find_or_create_by_id(result['id'])
      if pres.election_id.nil?
        pres.update_attributes :election_id => election_id, :title => result['title'], :description => result['description']
      end
      pres.snapshots.create(:at => Time.now, :score => result['score'])
    end
  end
  
  def score_at(dt)
    snap = snapshots.select { |snap| snap.at <= dt }.last
    snap ? snap.score : 0
  end
  
  def series
    { 
      :name => self.title.strip, 
      :data => self.snapshots.collect { |snap|
        [snap.at.to_i * 1000, snap.score ]
      }
    }
  end
  
end
