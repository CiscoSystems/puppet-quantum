require 'puppet'
require 'puppet/type/quantum_config'
describe 'Puppet::Type.type(:quantum_config)' do
  before :each do
    @nova_config = Puppet::Type.type(:quantum_config).new(:name => 'foo', :value => 'bar')
  end
  it 'should require a name' do
    expect {
      Puppet::Type.type(:quantum_config).new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end
  it 'should not expect a name with whitespace' do
    expect {
      Puppet::Type.type(:quantum_config).new(:name => 'f oo')
    }.to raise_error(Puppet::Error, /Invalid value/)
  end
  it 'should not require a value when ensure is absent' do
    Puppet::Type.type(:quantum_config).new(:name => 'foo', :ensure => :absent)
  end
  it 'should require a value when ensure is present' do
    expect {
      Puppet::Type.type(:quantum_config).new(:name => 'foo', :ensure => :present)
    }.to raise_error(Puppet::Error, /Property value must be set/)
  end
  it 'should accept a valid value' do
    @quantum_config[:value] = 'bar'
    @quantum_config[:value].should == 'bar'
  end
  it 'should not accept a value with whitespace' do
    @quantum_config[:value] = 'b ar'
    @quantum_config[:value].should == 'b ar'
  end
  it 'should accept valid ensure values' do
    @quantum_config[:ensure] = :present
    @quantum_config[:ensure].should == :present
    @quantum_config[:ensure] = :absent
    @quantum_config[:ensure].should == :absent
  end
  it 'should not accept invalid ensure values' do
    expect {
      @quantum_config[:ensure] = :latest
    }.to raise_error(Puppet::Error, /Invalid value/)
  end
end
