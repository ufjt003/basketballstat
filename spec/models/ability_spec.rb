require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:user) { FactoryGirl.create(:user) }
  subject { Ability.new(agent) }

  context "visitor" do
    let(:agent) { nil }
  end

  context "normal user" do
    let(:agent) { user }
    it { should be_able_to(:manage, :all) }
  end
end
