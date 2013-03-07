module TeamsHelper

  def page_title
    @title ||= params[:controller].humanize + " - " + params[:action].humanize
  end
  
  def new_team_button
    link_to new_team_path, class: 'btn' do
      content_tag('i', '', class: 'icon-plus') + " Neue Mannschaft".html_safe
    end
  end
  
end