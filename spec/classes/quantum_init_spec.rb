require 'spec_helper'

describe 'quantum' do

  let :facts do
    { :osfamily => 'Debian' }
  end

  describe 'with default parameters' do
    it { should contain_package('quantum').with_ensure('present') }

    it { should contain_file('/etc/quantum').with(
      'ensure'  => directory,
      'mode'    => 770,
      'owner'   => 'quantum',
      'group'   => 'root',
      'require' => 'Package[quantum]'
    )}

    it { should contain_quantum_config('verbose').with_value('False') }
    it { should contain_quantum_config('debug').with_value('False') }

    it { should contain_quantum_config('bind_host').with_value('0.0.0.0') }
    it { should contain_quantum_config('bind_port').with_value('9696') }

    it { should contain_quantum_config('auth_strategy').with_value('keystone') }
    it { should contain_quantum_config('core_plugin').with_value('quantum.plugins.openvswitch.ovs_quantum_plugin.OVSQuantumPluginV2') }
    it { should contain_quantum_config('control_exchange').with_value('quantum') }

    it { should contain_quantum_config('base_mac').with_value('fa:16:3e:00:00:00') }
    it { should contain_quantum_config('mac_generation_retries').with_value('16') }
    it { should contain_quantum_config('dhcp_lease_duration').with_value('120') }

    it { should contain_quantum_config('allow_bulk').with_value('True') }
    it { should contain_quantum_config('allow_overlapping_ips').with_value('False') }

    it { should contain_quantum_config('rabbit_addresses').with_value('default') }
    it { should contain_quantum_config('rabbit_password').with_value('guest') }
    it { should contain_quantum_config('rabbit_user').with_value('guest') }
    it { should contain_quantum_config('rabbit_virtual_host').with_value('/') }
    

    describe 'with parameters supplied' do

      let :params do
        {
          'verbose'                => 'True',
          'debug'                  => 'True',
          'bind_host'              => '1.1.1.1',
          'bind_port'       	   => '9695',
          'core_plugin'            => 'quantum.plugins.openvswitch.ovs_quantum_plugin.OVSQuantumPluginV1',
          'control_exchange'       => 'quantum-exchange',
          'base_mac'       	   => '11:11:11:11:11:11',
          'mac_generation_retries' => '1',
          'dhcp_lease_duration'    => '10',
          'allow_bulk'             => 'False',
          'allow_overlapping_ips'  => 'True',
          'rabbit_addresses'       => ['hare1:5673','hare2'],
          'rabbit_userid'          => 'rabbit_user',
          'rabbit_password'        => 'password',
          'rabbit_virtual_host'    => '/fake_rabbit',
          'auth_strategy'          => 'foo'
        }
      end

    it { should contain_quantum_config('verbose').with_value('True') }
    it { should contain_quantum_config('debug').with_value('True') }

    it { should contain_quantum_config('bind_host').with_value('1.1.1.1') }
    it { should contain_quantum_config('bind_port').with_value('9695') }

    it { should contain_quantum_config('auth_strategy').with_value('foo') }
    it { should contain_quantum_config('core_plugin').with_value('quantum.plugins.openvswitch.ovs_quantum_plugin.OVSQuantumPluginV1') }
    it { should contain_quantum_config('control_exchange').with_value('quantum-exchnage') }

    it { should contain_quantum_config('base_mac').with_value('11:11:11:11:11:11') }
    it { should contain_quantum_config('mac_generation_retries').with_value('1') }
    it { should contain_quantum_config('dhcp_lease_duration').with_value('10') }

    it { should contain_quantum_config('allow_bulk').with_value('False') }
    it { should contain_quantum_config('allow_overlapping_ips').with_value('True') }

    it { should contain_quantum_config('rabbit_addresses').with_value('hare1:5673,hare2:5672') }
    it { should contain_quantum_config('rabbit_password').with_value('password') }
    it { should contain_quantum_config('rabbit_user').with_value('rabbit_user') }
    it { should contain_quantum_config('rabbit_virtual_host').with_value('/fake_rabbit') }

    end

  end
end
