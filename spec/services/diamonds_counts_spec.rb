require 'rails_helper'

RSpec.describe DiamondsCount do
  it '1: retornando 1 diamente e 3 grãos de areia' do
    str1 = '<.<<.<>.>>>'
    count1 = DiamondsCount.new(str1)
    result = count1.count
    expect(result).to eq("Diamonds: 1 / Grains: 3")
  end

  it '2: retornando 1 diamente e 3 grãos de areia' do
    str2 = '<<.<<..>><>><.>.>.<<.>.<.>>>><>><>>'
    count2 = DiamondsCount.new(str2)
    result = count2.count
    expect(result).to eq("Diamonds: 3 / Grains: 9")
  end
end