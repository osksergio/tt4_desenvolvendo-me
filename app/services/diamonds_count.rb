class DiamondsCount
  def initialize(str)
    @str = str
  end

  def count
    diamonds = 0
    grains = 0
    old = ''

    @str.each_char do |c|
      grains += 1 if c == '.'
      old = c if c == '<'
      if (c == '>') && (old == '<')
        diamonds += 1
        old = ''
      elsif (c == '.')
        old = ''
      end
    end

    "Diamonds: #{diamonds} / Grains: #{grains}"
  end
end