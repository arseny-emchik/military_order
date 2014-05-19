class Celebrations

  #current_year = Date.current.year
  #holidays = []
  #holidays << Date.new(current_year, 5, 9) # 9 мая
  #holidays << Date.new(current_year, 7, 3) # день конституции
  #holidays << Date.new(current_year, 1, 1) # новый год
  #holidays << Date.new(current_year, 3, 8) # 8 марта
  #holidays << Date.new(current_year, 5, 1) # 1 мая
  #holidays << Date.new(current_year, 11, 7) # день Октябрьской революции
  #holidays << Date.new(current_year, 1, 7) # Рождество Христово
  #holidays << Date.new(current_year, 12, 25) # Рождество Христово

  HASH_CELEBR = {
      5 => [9, 1],
      7 => [3],
      1 => [1, 7],
      3 => [8],
      11 => [7],
      12 => [25]
  }.freeze

  def self.is_in?(n_month, n_day)
    days = HASH_CELEBR[n_month]
    days.nil? == false && days.include?(n_day) == true
  end
end