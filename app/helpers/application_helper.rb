module ApplicationHelper

  def page_title
    @title ||= params[:controller].humanize + " - " + params[:action].humanize
  end
  
end
