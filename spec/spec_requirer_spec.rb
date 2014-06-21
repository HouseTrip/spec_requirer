describe SpecRequirer do
  describe '#setup' do
    it 'adds Kernal#uses_models' do
      subject.setup
      expect(Kernel).to respond_to :uses_models
    end

    it 'adds Kernal#require_model' do
      subject.setup
      expect(Kernel).to respond_to :require_model
    end

    it 'does not break Kernal#respond_to' do
      subject.setup
      expect(Kernel).to respond_to :puts
    end
  end
end
