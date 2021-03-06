require 'spec_helper'
describe 'splunk::output::tcpgroup', :type => :define do
  
  concat_file = '/var/lib/puppet/concat/outputs.conf/fragments/10_tcpGroup-default'
  target_group = 'Target'

  let(:title) { 'default'}
  let(:facts) {{ :concat_basedir => '/var/lib/puppet/concat', :id => 'root' }}
  
  let(:params) {{ :target_group => target_group }}
  describe 'When creating a indexAndForward stanza' do
    it {
      should contain_file('outputs.conf').with_path('/opt/splunk/etc/system/local/outputs.conf')
      should contain_file(concat_file).with_content(/\[tcpout:#{target_group}\]/)
    }
    context 'with $server set' do
      context 'to a single string' do
        let (:params) {{ :target_group => target_group, :server => 'example.com' }}
        it {
          should contain_file(concat_file).with_content(/server = example\.com/m)
        }
      end
      context 'to an array' do
        let (:params) {{ :target_group => target_group, :server => ['example.com', '10.0.2.3'] }}
        it {
          should contain_file(concat_file).with_content(/server = example\.com, 10\.0\.2\.3/m)
        }
      end
    end
    context "with sendCookedData" do
      [true, false].each do |sendCookedData|
        context "set to #{sendCookedData}" do
          let(:params) {{ :target_group => target_group, :sendCookedData => sendCookedData }}
          it {
            should contain_file(concat_file).with_content(/sendCookedData = #{sendCookedData}/m)
          }
        end
      end
      [9999, "false", "true", "other thing"].each do |sendCookedData|
        context "set to invalid value #{sendCookedData}" do
          let (:params) {{ :target_group => target_group,:sendCookedData => sendCookedData}}
          it {
            expect {
              should contain_file(concat_file)
            }.to raise_error(Puppet::Error, /\"#{sendCookedData}\" is not a boolean\./)
          }
        end
      end
    end
    context "with blockOnCloning" do
      [true, false].each do |blockOnCloning|
        context "set to #{blockOnCloning}" do
          let(:params) {{ :target_group => target_group, :blockOnCloning => blockOnCloning }}
          it {
            should contain_file(concat_file).with_content(/blockOnCloning = #{blockOnCloning}/m)
          }
        end
      end
      [9999, "false", "true", "other thing"].each do |blockOnCloning|
        context "set to invalid value #{blockOnCloning}" do
          let (:params) {{ :target_group => target_group,:blockOnCloning => blockOnCloning}}
          it {
            expect {
              should contain_file(concat_file)
            }.to raise_error(Puppet::Error, /\"#{blockOnCloning}\" is not a boolean\./)
          }
        end
      end
    end
    context "with compressed" do
      [true, false].each do |compressed|
        context "set to #{compressed}" do
          let(:params) {{ :target_group => target_group, :compressed => compressed }}
          it {
            should contain_file(concat_file).with_content(/compressed = #{compressed}/m)
          }
        end
      end
      [9999, "false", "true", "other thing"].each do |compressed|
        context "set to invalid value #{compressed}" do
          let (:params) {{ :target_group => target_group,:compressed => compressed}}
          it {
            expect {
              should contain_file(concat_file)
            }.to raise_error(Puppet::Error, /\"#{compressed}\" is not a boolean\./)
          }
        end
      end
    end
    context "with negotiateNewProtocol" do
      [true, false].each do |negotiateNewProtocol|
        context "set to #{negotiateNewProtocol}" do
          let(:params) {{ :target_group => target_group, :negotiateNewProtocol => negotiateNewProtocol }}
          it {
            should contain_file(concat_file).with_content(/negotiateNewProtocol = #{negotiateNewProtocol}/m)
          }
        end
      end
      [9999, "false", "true", "other thing"].each do |negotiateNewProtocol|
        context "set to invalid value #{negotiateNewProtocol}" do
          let (:params) {{ :target_group => target_group,:negotiateNewProtocol => negotiateNewProtocol}}
          it {
            expect {
              should contain_file(concat_file)
            }.to raise_error(Puppet::Error, /\"#{negotiateNewProtocol}\" is not a boolean\./)
          }
        end
      end
    end
    context "with forceTimebasedAutoLB" do
      [true, false].each do |forceTimebasedAutoLB|
        context "set to #{forceTimebasedAutoLB}" do
          let(:params) {{ :target_group => target_group, :forceTimebasedAutoLB => forceTimebasedAutoLB }}
          it {
            should contain_file(concat_file).with_content(/forceTimebasedAutoLB = #{forceTimebasedAutoLB}/m)
          }
        end
      end
      [9999, "false", "true", "other thing"].each do |forceTimebasedAutoLB|
        context "set to invalid value #{forceTimebasedAutoLB}" do
          let (:params) {{ :target_group => target_group,:forceTimebasedAutoLB => forceTimebasedAutoLB}}
          it {
            expect {
              should contain_file(concat_file)
            }.to raise_error(Puppet::Error, /\"#{forceTimebasedAutoLB}\" is not a boolean\./)
          }
        end
      end
    end
    context "with useACK" do
      [true, false].each do |useACK|
        context "set to #{useACK}" do
          let(:params) {{ :target_group => target_group, :useACK => useACK }}
          it {
            should contain_file(concat_file).with_content(/useACK = #{useACK}/m)
          }
        end
      end
      [9999, "false", "true", "other thing"].each do |useACK|
        context "set to invalid value #{useACK}" do
          let (:params) {{ :target_group => target_group,:useACK => useACK}}
          it {
            expect {
              should contain_file(concat_file)
            }.to raise_error(Puppet::Error, /\"#{useACK}\" is not a boolean\./)
          }
        end
      end
    end
  end
end