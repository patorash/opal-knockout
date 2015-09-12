require "spec_helper"

class ComputedViewModel < Knockout::ViewModel
  attr_observable :first_name, :last_name
  attr_computed :full_name do
    "#{self.first_name.to_s} #{self.last_name.to_s}"
  end

  def initialize(first_name='', last_name='')
    self.first_name = first_name
    self.last_name = last_name
  end
end

describe Knockout::Computed do
  html <<-HTML
    <div data-bind="with: user">
      <div id="user_full_name" data-bind="text: full_name">
    </div>
  HTML

  before do
    @computed_vm = ComputedViewModel.new(first_name='Taro', last_name='Tanaka')
    Knockout.apply_bindings(user: @computed_vm)
  end

  after do
    Knockout.clean_node
  end

  subject { Element['#user_full_name'] }

  it 'should binding full_name' do
    expect(subject.html).to eq('Taro Tanaka')
  end

  it 'should change binding full_name' do
    @computed_vm.first_name = 'Jiro'
    expect(subject.html).to eq('Jiro Tanaka')
  end
end
