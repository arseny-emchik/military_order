Rank.destroy_all

mas_rank = %w(капитан майор подполковник полковник)

mas_rank.each do |rank|
  r = Rank.new
  r.title = rank
  r.save!
end
