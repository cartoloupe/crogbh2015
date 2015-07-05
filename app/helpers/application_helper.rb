module ApplicationHelper
  def display_map address
    divid = SecureRandom.uuid
    hamlchunk = <<HEREDOC
:javascript
  $(function(){codeAddress("#{address.gsub(/\n/, '')}", "#{divid}")});
##{divid}.map
HEREDOC

    Haml::Engine.new(hamlchunk).render
  end

  def humanize input
    input
      .to_s
      .split('-')
      .map(&:capitalize)
      .join(' ')
  end
end
