require "spec_helper"

class ObservableViewModel < Knockout::ViewModel
  attr_observable :name
  def initialize(name: '')
    self.name = name
  end
end

describe Knockout::Observable do
  html <<-HTML
    <div data-bind="with: user">
      <div id="user_name" data-bind="text: name"></div>
    </div>
  HTML

  before do
    @observable_vm = ObservableViewModel.new(name: 'Bob')
    Knockout.apply_bindings(user: @observable_vm)
  end

  after do
    Knockout.clean_node
  end

  subject { Element['#user_name'] }

  it 'should binding name' do
    expect(subject.html).to eq('Bob')
  end

  it 'should change binding name' do
    @observable_vm.name = 'Sam'
    expect(subject.html).to eq('Sam')
  end

  it 'should plus binding name' do
    @observable_vm.name += ' and Sam'
    expect(subject.html).to eq('Bob and Sam')
  end
end