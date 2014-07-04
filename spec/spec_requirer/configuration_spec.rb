describe SpecRequirer::Configuration do
  it 'responds to #app_root=' do
    expect(subject).to respond_to :app_root=
  end

  it '#app_root raises error if unset' do
    expect { subject.app_root }.to raise_error
  end
end
