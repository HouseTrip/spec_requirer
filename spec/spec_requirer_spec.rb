describe SpecRequirer do
  let(:app_root) { Pathname(File.dirname(__FILE__)).join('app') }

  describe '#setup' do
    before { subject.setup(components: ['models']) }

    it 'adds Object#uses_models' do
      expect(Object).to respond_to :uses_models
    end

    it 'adds Object#require_model' do
      expect(Object).to respond_to :require_models
    end

    it 'does not break Object#respond_to' do
      expect(Object).to respond_to :object_id
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
    before { subject.setup(app_root: app_root, components: ['models']) }

    it 'adds models path to LOAD_PATH' do
      uses_models
      expect($LOAD_PATH).to include app_root.join('models').to_s
    end
  end

  describe '#require_model' do
    before { subject.setup(app_root: app_root, components: ['models']) }

    it 'requires a model file' do
      expect { require_models(:user, :award) }.to_not raise_error
      expect { User.new }.to_not raise_error
      expect { Award.new }.to_not raise_error
    end
  end


  describe '#uses' do
    before { subject.setup(app_root: app_root, components: ['models']) }

    it 'adds given components to LOAD_PATH' do
      uses :models, :presenters
      expect($LOAD_PATH).to include app_root.join('models').to_s
      expect($LOAD_PATH).to include app_root.join('presenters').to_s
    end
  end
end
