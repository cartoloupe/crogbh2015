module ApplicationHelper
  def display_map address
    divid = SecureRandom.uuid

    hamlchunk = <<HEREDOC
:javascript
  $(function(){codeAddress("#{address.gsub(/\n/, ' ')}", "#{divid}")});
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

  def newline_to_br input
    input
    .gsub(/\</, '&lt;') .gsub(/\>/, '&gt;')    # escape any existing tags
    .gsub(/(?:\n\r?|\r\n?)/, '<br>')           # convert all styles of line breaks
    .gsub(/(?:^(?:\<br\>)+|(?:\<br\>)+$)/, '') # remove leading or trailing breaks
  end

  def header_title_for input
    trimmed_input = input ? input.strip : nil
    if input && trimmed_input.length != 0
      "#{trimmed_input} - #{SITE_TITLE}"
    else
      SITE_TITLE
    end
  end

  private

  SITE_TITLE = 'OneSource'.freeze
end
