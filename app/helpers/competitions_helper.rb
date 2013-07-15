module CompetitionsHelper

  def new_competition_button
    link_to new_season_competition_path(@season), class: 'btn' do
      content_tag('i', '', class: 'icon-plus') + " Neuer Wettbewerb".html_safe
    end
  end
  
  def find_team_in_plan(competition, position)
    competition.plan_position[position] == 0 ? "Unbekannte Mannschaft" : competition.teams.find(competition.plan_position[position]).short_name
  end
end