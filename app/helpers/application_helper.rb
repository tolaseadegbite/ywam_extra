module ApplicationHelper

  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end

  def render_date(object)
    if object.created_at > 1.year.ago
      object.created_at.strftime("%B %d")
    else
      object.created_at.strftime("%B %d, %Y")
    end
  end
end