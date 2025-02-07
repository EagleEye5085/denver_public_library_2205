require './lib/library'
require './lib/author'
require './lib/book'

RSpec.describe Library do
  before :each do
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @professor = @charlotte_bronte.write("The Professor", "1857")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  it "is an instance of a library" do
    expect(@dpl).to be_a(Library)
  end

  it "has a name" do
    expect(@dpl.name).to eq("Denver Public Library")
  end

  it "has no books by default" do
    expect(@dpl.books).to eq([])
  end

  it "has no authors by default" do
    expect(@dpl.authors).to eq([])
  end

  it "can add authors and their books" do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.authors).to eq([@charlotte_bronte, @harper_lee])

    expect(@dpl.books).to eq([@jane_eyre, @professor, @villette, @mockingbird])
  end

  it "can get a publication time frame" do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.publication_time_frame_for(@charlotte_bronte)).to eq({start: "1847", end: "1857"})

    expect(@dpl.publication_time_frame_for(@harper_lee)).to eq({start: "1960", end: "1960"})
  end

  it "cannot checkout books it does not have" do
    expect(@dpl.checkout(@mockingbird)).to eq(false)
    expect(@dpl.checkout(@jane_eyre)).to eq(false)
  end

  it "can checkout books" do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
# require 'pry'; binding.pry
    expect(@dpl.checkout(@jane_eyre)).to eq(true)

    expect(@dpl.checked_out_books).to eq([@jane_eyre])

    expect(@dpl.checkout(@jane_eyre)).to eq(false)
  end

  it "can have books returned" do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    @dpl.checkout(@jane_eyre)
    @dpl.return(@jane_eyre)

    expect(@dpl.checked_out_books).to eq([])
  end

    # @dpl.checkout(@jane_eyre)
    # @dpl.checkout(@villette)

end
