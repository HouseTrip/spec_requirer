describe SpecRequirer do

  describe '#setup' do
    before { subject.setup }

    it 'adds Kernal#uses_models' do
      expect(Kernel).to respond_to :uses_models
    end

    it 'adds Kernal#require_model' do
      expect(Kernel).to respond_to :require_model
    end

    it 'does not break Kernal#respond_to' do
      expect(Kernel).to respond_to :puts
    end
  end

  describe '#setup options' do
    it 'accepts configuration' do
      subject.setup(app_root: '/foo')
      expect(subject.configuration.app_root).to eq '/foo'
    end
  end

  describe '#uses_models' do
    let(:app_root) { Pathname(File.dirname(__FILE__)).join('app') }

    before do
      subject.setup(app_root: app_root)
    end

    it 'add model path to LOAD_PATH' do
      Kernel.uses_models
      expect($LOAD_PATH).to include app_root.join('models').to_s
    end
  end

  describe '#require_model' do
    let(:app_root) { Pathname(File.dirname(__FILE__)).join('app') }

    before { subject.setup }

    it 'requires a model file' do
      expect { Kernel.require_model(:user) }.to_not raise_error
    end
  end
end
