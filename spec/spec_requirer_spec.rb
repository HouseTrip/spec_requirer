describe SpecRequirer do
  describe '#setup' do
    before { subject.setup(components: ['models']) }

    it 'adds Kernal#uses_models' do
      expect(Kernel).to respond_to :uses_models
    end

    it 'adds Kernal#require_model' do
      expect(Kernel).to respond_to :require_models
    end

    it 'does not break Kernal#respond_to' do
      expect(Kernel).to respond_to :puts
    end
  end

  describe '#setup options' do
    it 'accepts configuration' do
      subject.setup(app_root: '/foo', components: ['foo'])
      expect(subject.configuration.app_root.to_s).to eq '/foo'
      expect(subject.configuration.components).to eq ['foo']
    end
  end

  describe '#uses_models' do
    let(:app_root) { Pathname(File.dirname(__FILE__)).join('app') }

    before { subject.setup(app_root: app_root, components: ['models']) }

    it 'adds models path to LOAD_PATH' do
      uses_models
      expect($LOAD_PATH).to include app_root.join('models').to_s
    end
  end

  describe '#require_model' do
    let(:app_root) { Pathname(File.dirname(__FILE__)).join('app') }

    before { subject.setup(app_root: app_root, components: ['models']) }

    it 'requires a model file' do
      expect { require_models(:user, :award) }.to_not raise_error
      expect { User.new }.to_not raise_error
      expect { Award.new }.to_not raise_error
    end
  end
end
