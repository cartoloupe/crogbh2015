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

  # this is kind of a silly method to have.. i originally wrote it thinking
  # that we might need to wrap the input somehow but i am having a hard time
  # coming up with the reason we would need this. in fact i will probably remove
  # this method before i create a pull request
  def page_title_for input
    input
  end

  private

  SITE_TITLE = 'OneSource'.freeze
end
