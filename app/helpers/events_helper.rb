module EventsHelper
  def day_select
    %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday).map.with_index { |item, index| [item, index]}
  end

  def game_select(games)
    games.map {|g| [g.name, g.id]}
  end

end
