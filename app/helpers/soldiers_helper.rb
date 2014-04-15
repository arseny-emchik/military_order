module SoldiersHelper
  def datepicker(id, value_name, default_date)
    content_tag(:div, class: 'form-group') do
      content_tag(:div, class: 'input-group date', id: id.to_s) do
        content_tag(:input, name: value_name.to_s, type: 'text', class: 'form-control', placeholder: default_date.strftime('%d.%m.%Y') ) do
          '<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>'.html_safe
        end
      end
    end

  end
end