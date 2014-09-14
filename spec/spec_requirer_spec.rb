describe SpecRequirer do

  let(:app_root) { Pathname(File.dirname(__FILE__)).join('app') }

  describe 'setup options' do
    it 'accepts configurion' do
      SpecRequirer.setup(app_root: '/foo', components: ['foo'])
      expect(SpecRequirer.configuration.app_root.to_s).to eq '/foo'
      expect(SpecRequirer.configuration.components).to eq ['foo']
    end
  end

  context "included methods" do
    let(:class_under_test) { ClassUnderTest.new }

    before do
      SpecRequirer.setup(app_root: app_root, components: ['models'])
      class ClassUnderTest
        include SpecRequirer
      end
    end

    describe '#uses_models' do
      it 'adds models path to LOAD_PATH' do
        class_under_test.spec_uses_models
        expect($LOAD_PATH).to include app_root.join('models').to_s
      end
    end

    describe '#require_model' do
      it 'requires a model file' do
        expect { class_under_test.require_models(:user, :award) }.to_not raise_error
        expect { User.new }.to_not raise_error
        expect { Award.new }.to_not raise_error
      end
    end

    describe '#uses' do
      it 'adds given components to LOAD_PATH' do
        class_under_test.spec_uses :models, :presenters
        expect($LOAD_PATH).to include app_root.join('models').to_s
        expect($LOAD_PATH).to include app_root.join('presenters').to_s
      end
    end
  end
end
