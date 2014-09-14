describe SpecRequirer::Loader do
  let(:app_root)      { Pathname(File.dirname(__FILE__)) }
  let(:components)    { ['models', 'presenters'] }
  let(:configuration) do
    double('configuration',
        components:   components,
        app_root:     app_root
    )
  end

  subject { Class.new }

  describe "extended" do
    before { subject.extend(SpecRequirer::Loader.new(configuration))  }

    it 'creates spec_uses_* methods for each component in configuration' do
      components.each do |component|
        expect(subject).to respond_to "spec_uses_#{component}"
      end
    end

    it 'creates require_* methods for each component in configuration' do
      components.each do |component|
        expect(subject).to respond_to "require_#{component}"
      end
    end
  end

  describe "included" do
    let(:class_under_test) { subject.new }

    before { subject.include(SpecRequirer::Loader.new(configuration)) }

    it 'creates a uses method' do
      expect(class_under_test).to respond_to(:spec_uses)
    end
  end
end
