describe SpecRequirer::Loader do
  let(:components) { ['models', 'presenters'] }
  let(:configuration) { double('configuration', components: components) }

  subject { SpecRequirer::Loader.new(configuration) }

  it 'creates uses_* methods for each component in configuration' do

    components.each do |component|
      expect(subject).to respond_to "uses_#{component}"
    end
  end
end
