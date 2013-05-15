module TrialsHelper
  def link_to_add_choice(name, index = 'index_to_replace', options = {}, &block)
    html = capture(&block)
    js = %{
      $('#choices-#{index}.choices').append('#{escape_javascript html}');
    }
    link_to_function name, js, options
  end

  def link_to_delete_choice(name, options = {})
    js = %{
      $(this).parents('.choice').remove();
    }
    link_to_function name, js, options
  end

  def link_to_add_question(name, options = {}, &block)
    html = capture(&block)
    js = %{
      var tid = new Date().getTime();
      var html = '#{escape_javascript html}'.replace(/index_to_replace/g, tid);
      $(html).appendTo('.questions');
    }
    link_to_function name, js, options
  end

  def link_to_delete_question(name, index = 'index_to_replace', options = {})
    js = %{
      $('#question-#{index}').remove();
    }
    link_to_function name, js, options
  end
end
