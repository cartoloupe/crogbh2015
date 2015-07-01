module ApplicationHelper

  def display_map address
    divid = SecureRandom.uuid
    hamlchunk = <<HEREDOC
:javascript
  $(function(){codeAddress("#{address}", "#{divid}")});
##{divid}.map
HEREDOC

    Haml::Engine.new(hamlchunk).render
  end

end
