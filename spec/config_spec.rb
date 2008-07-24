require File.dirname(__FILE__) + '/spec_helper'

describe Confiture::AppConfig do
  
  before(:each) do
    confiture = Mash.new("app_root" => '/var/app')
    Confiture.stub!(:config).and_return(confiture)
  end
  
  it "should set some sensible defaults" do
    config = Confiture::AppConfig.new( :port => 8000, :name => 'monkey' )
    config.name.should == 'monkey'
    config.kind.should == "rails"
    config.ports.should == [8000]
    config.servers.should == 1
    config.uid.should == "monkey"
    config.gid.should == "monkey"
    config.cwd.should == "/var/app/monkey/current"
    config.docroot.should == "/var/app/monkey/current/public"
    config.address.should == "127.0.0.1"
    config.balancer_name.should == "balancer://monkey_cluster"
  end
  
  it "should allow ovveride of existing options" do
    config = Confiture::AppConfig.new(
      :port => 8000,
      :name => 'monkey',
      :balancer_name => 'monkey://blah'
    )
    config.balancer_name.should == 'monkey://blah'
  end
end