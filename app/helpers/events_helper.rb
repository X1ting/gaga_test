module EventsHelper
  def day_select
    %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday).map.with_index { |item, index| [item, index]}
  end

  def game_select
    Game.all.map {|game| [game.name, game.id]}
  end

end
