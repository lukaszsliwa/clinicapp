module QuestionsHelper
  def link_to_add_choice(name, options = {}, &block)
    html = capture(&block)
    js = %{
      $('#{escape_javascript html}').appendTo('.choices');
    }
    link_to_function name, js, options
  end

  def link_to_delete_choice(name, options = {})
    js = %{
      $(this).parents('.choice').remove();
    }
    link_to_function name, js, options
  end
end
