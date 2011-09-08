module MealsHelper
  def prev_next(meal)
    haml_tag(:div, :class => 'prev_next', :style => 'font-size: 0.7em; color: #ccc; text-align: right; float: right') do
      haml_concat([ link_to("<< prev", meal.prev_meal),
        '&nbsp;&nbsp;&nbsp;',
        link_to("next >>", meal.next_meal),
      ].join)
    end
  end
end
