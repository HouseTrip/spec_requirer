describe SpecRequirer::Loader do
  let(:app_root)      { Pathname(File.dirname(__FILE__)) }
  let(:components)    { ['models', 'presenters'] }
  let(:configuration) { double('configuration', components: components,
                                                app_root:   app_root) }

  subject { Class.new }

  before { subject.extend(SpecRequirer::Loader.new(configuration))  }

  it 'creates uses_* methods for each component in configuration' do
    components.each do |component|
      expect(subject).to respond_to "uses_#{component}"
    end
  end

  it 'creates require_* methods for each component in configuration' do
    components.each do |component|
      expect(subject).to respond_to "require_#{component}"
    end
  end
end
