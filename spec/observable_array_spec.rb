require "spec_helper"

class ObservableArrayViewModel < Knockout::ViewModel
  attr_observable_array :books
end

class Book
  attr_accessor :title, :price
  def initialize(title=nil, price=nil)
    self.title = title
    self.price = price
  end
end

describe Knockout::ObservableArray do
  html <<-HTML
    <div data-bind="with: book_list">
      <dl id="book_list" data-bind="foreach: books">
        <dt data-bind="text: title"></dt>
        <dd data-bind="text: price"></dd>
      </dl>
    </div>
  HTML

  before do
    @observable_array_vm = ObservableArrayViewModel.new
    Knockout.apply_bindings(book_list: @observable_array_vm)
  end

  after do
    Knockout.clean_node
  end

  subject { Element['#book_list'] }

  it 'should binding books' do
    @observable_array_vm.books.push(Book.new('The Rspec book', 3980))
    expect(subject.find('dt').first.text).to eq 'The Rspec book'
    expect(subject.find('dd').first.text).to eq '3980'
  end

  describe 'add 10 books' do
    before do
      500.step(5000, 500).with_index(1) do |price, i|
        @observable_array_vm.books.push(Book.new("Ruby (#{i})", price))
      end
    end

    subject { @observable_array_vm.books }

    it 'should pop book' do
      book = subject.pop
      expect(book.title).to eq 'Ruby (10)'
      expect(book.price).to eq 5000
    end

    it 'should shift book' do
      book = subject.shift
      expect(book.title).to eq 'Ruby (1)'
      expect(book.price).to eq 500
    end

    it 'should reverse books' do
      subject.reverse
      expect(subject.to_a.map(&:title)).to eq (1..10).to_a.reverse.map { |i| "Ruby (#{i})"}
    end

    it 'should remove item' do
      book = subject.to_a[2]
      subject.remove(book)
      expect(subject.to_a.map(&:title)).to eq [
                                                  "Ruby (1)",
                                                  "Ruby (2)",
                                                  "Ruby (4)",
                                                  "Ruby (5)",
                                                  "Ruby (6)",
                                                  "Ruby (7)",
                                                  "Ruby (8)",
                                                  "Ruby (9)",
                                                  "Ruby (10)",
                                              ]
    end

    it 'should remove items' do
      books = subject.to_a.first(5)
      subject.remove(books)
      expect(subject.to_a.map(&:title)).to eq [
                                                  "Ruby (6)",
                                                  "Ruby (7)",
                                                  "Ruby (8)",
                                                  "Ruby (9)",
                                                  "Ruby (10)",
                                              ]
    end

    it 'should remove items if price over 3000' do
      subject.remove_if { |book| book.price >= 3000 }
      expect(subject.to_a.map(&:price)).to eq [
                                                  500,
                                                  1000,
                                                  1500,
                                                  2000,
                                                  2500
                                              ]
    end

    it 'should remove all items' do
      subject.remove_all
      expect(subject.size).to eq 0
    end

    it 'should clear items' do
      subject.clear
      expect(subject.size).to eq 0
    end

    it 'should destroy item' do
      book = subject.to_a[2]
      subject.destroy(book)
      # 削除されるわけではない
      expect(subject.to_a.map(&:title)).to eq [
                                                  "Ruby (1)",
                                                  "Ruby (2)",
                                                  "Ruby (3)",
                                                  "Ruby (4)",
                                                  "Ruby (5)",
                                                  "Ruby (6)",
                                                  "Ruby (7)",
                                                  "Ruby (8)",
                                                  "Ruby (9)",
                                                  "Ruby (10)",
                                              ]
      expect(subject.to_a.map{ |book| Native(`#{book}._destroy`) }).to eq [
                                                                              nil,
                                                                              nil,
                                                                              true,
                                                                              nil,
                                                                              nil,
                                                                              nil,
                                                                              nil,
                                                                              nil,
                                                                              nil,
                                                                              nil,
                                                                          ]
    end

    it 'should destroy items' do
      books = subject.to_a.first(5)
      subject.destroy(books)
      expect(subject.to_a.map{ |book| Native(`#{book}._destroy`) }).to eq [
                                                                              true,
                                                                              true,
                                                                              true,
                                                                              true,
                                                                              true,
                                                                              nil,
                                                                              nil,
                                                                              nil,
                                                                              nil,
                                                                              nil,
                                                                          ]
      expect(subject.only_destroyed).to eq books
      expect(subject.without_destroyed).to eq (subject.to_a - books)
    end

    it 'should destroy items if price over 3000' do
      subject.destroy_if { |book| book.price >= 3000 }
      expect(subject.without_destroyed.map(&:price)).to eq [

                                                               500,
                                                               1000,
                                                               1500,
                                                               2000,
                                                               2500
                                                           ]
    end

    it 'should destroy all items' do
      subject.destroy_all
      expect(subject.without_destroyed.size).to eq 0
    end

  end
end