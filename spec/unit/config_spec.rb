# frozen_string_literal: true

RSpec.describe Queen::Config do
  it "normalizes keys" do
    hash = {
      "rules" => {
        "profanity"=> {
          "enabled"=>false,
          "exclude"=>[]
         },
        "word_spelling"=> {
          "enabled"=>false,
          "exclude"=>[]
        }
      }
    }

    expect(described_class.normalize_hash(hash)).to eq({rules: {profanity: {enabled: false, exclude: []}, word_spelling: {enabled: false, exclude: []}}})
  end

  it "finds a rule" do
    hash = {
      "rules" => {
        "profanity"=> {
          "enabled"=>false,
          "exclude"=>[]
         }
      }
    }

    config = Queen::Config.coerce(hash)

    expect(config.for_rule(:profanity)).to eq({enabled: false, exclude: []})
  end
end
