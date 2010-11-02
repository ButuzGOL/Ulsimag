module ApplicationHelper

   # Return a title on a per-page basis.
  def title
    base_title = "Ulsimag"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
    image_tag("logo.png", :alt => "Ulsimag", :class => "round")
  end

  def this_year
    DateTime.now.year
  end
  
end
