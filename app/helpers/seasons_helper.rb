module SeasonsHelper

  def new_season_button
    link_to new_season_path, class: 'btn' do
      content_tag('i', '', class: 'icon-plus') + " Neue Saison".html_safe
    end
  end
  
end