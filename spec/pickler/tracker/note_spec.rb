require File.expand_path(File.dirname(__FILE__) + '/../../../spec/spec_helper')

describe Pickler::Tracker::Note do

  before do
    @text = ""
    @note = Pickler::Tracker::Note.new(nil, :noted_at => Time.utc(2008, 1, 2), :text => @text)
  end

  it "should have a date" do
    expect(@note.date).to eq Date.new(2008,1,2)
  end

  describe "#lines" do
    it "should strip leading and trailing whitespace" do
      @text.replace(" x ")
      expect(@note.lines).to eq ["x"]
    end

    it "should favor the longest possible line" do
      @text.replace(("x"*35+" ")*3)
      expect(@note.lines).to eq ["x"*35+" "+"x"*35,"x"*35]
    end

    it "should not break a long word" do
      @text.replace("x"*81)
      expect(@note.lines).to eq ["x"*81]
    end

    it "should honor newlines" do
      @text.replace("a\nb\n\nc")
      expect(@note.lines).to eq ["a","b","","c"]
    end
  end

end
