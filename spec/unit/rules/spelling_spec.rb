# frozen_string_literal: true

RSpec.describe Queen::Rules::Spelling do
  it "defines a name" do
    spelling = Queen::Rules::Spelling.new
    expect(spelling.name).to eq('Spelling')
  end

  it "cheks for word spelling reprimands" do
    spelling = Queen::Rules::Spelling.new

    spelling.check('cookie')

    expect(spelling.reprimands).to eq([])
  end

  it "allows to change language" do
    spelling = Queen::Rules::Spelling.new(lang: 'en_GB')

    spelling.check('colorize')

    expect(spelling.reprimands).not_to be_empty
  end

  it "finds no suggestions" do
    spelling = Queen::Rules::Spelling.new

    spelling.check('asdfadsfasdf')
    reprimand = spelling.reprimands.first

    expect(reprimand.message).to eq("\e[33masdfadsfasdf\e[0m might not be spelled correctly. Spelling suggestions: Nothing matches.")
  end

  it "provides suggestions for misspelled word" do
    spelling = Queen::Rules::Spelling.new

    spelling.check('cookei')

    reprimand = spelling.reprimands.first
    expect(reprimand.line).to eq(0)
    expect(reprimand.column).to eq(0)
    expect(reprimand.message).to eq("\e[33mcookei\e[0m might not be spelled correctly. Spelling suggestions: cookie, Cooke, cooker, Coke, Cook, coke")
  end

  it "provides misspellings for a text" do
    spelling = Queen::Rules::Spelling.new
    text = "There is a cookei on a table.\nAnd a botle of mikl."

    spelling.check(text)

    expect(spelling.reprimands.map(&:line)).to eq([0, 1, 1])
    expect(spelling.reprimands.map(&:column)).to eq([11, 6, 15])
    expect(spelling.reprimands[0].message).to include('cookie')
    expect(spelling.reprimands[1].message).to include('bottle')
    expect(spelling.reprimands[2].message).to include('milk')
  end
end
