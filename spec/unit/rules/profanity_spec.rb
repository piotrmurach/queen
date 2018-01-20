# frozen_string_literal: true

RSpec.describe Queen::Rules::Profanity do
  it "defines a name" do
    profanity = Queen::Rules::Profanity.new
    expect(profanity.name).to eq('Profanity')
  end

  it "checks for word profanities reprimands" do
    profanity = Queen::Rules::Profanity.new

    profanity.check('ass')

    expect(profanity.reprimands).not_to be_empty
  end

  it "checks for non-stem words" do
    profanity = Queen::Rules::Profanity.new

    profanity.check('Fucking')
    reprimand = profanity.reprimands.first

    expect(reprimand.message).to eq("\e[33mFucking\e[0m might be viewed as profane. Consider removing this word.")
  end

  it "checks a text for profanities" do
    profanity = Queen::Rules::Profanity.new
    text = "Kicked friend in the ass\nHis rear end hurt like hell."

    profanity.check(text)

    expect(profanity.reprimands.map(&:line)).to eq([0, 1])
    expect(profanity.reprimands.map(&:column)).to eq([21, 23])
    expect(profanity.reprimands[0].message).to include('ass')
    expect(profanity.reprimands[1].message).to include('hell')
  end
end
