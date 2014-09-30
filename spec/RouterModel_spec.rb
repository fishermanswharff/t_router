require 'spec_helper'
require_relative '../lib/RouterModel.rb'

describe RouterModel do

  before(:all) do
    @stops = "park street, state".scan(/\b[\w\s\/]+/im)
  end

  it 'has and an origin and destination' do
    expect(@stops.length).to eq 2 #=>
    expect(@stops).to eq ["park street", "state"]
  end

  it 'has a valid origin and destination' do

  end

end
