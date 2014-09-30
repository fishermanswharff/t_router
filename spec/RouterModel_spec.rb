require 'spec_helper'
require_relative '../lib/RouterModel.rb'

describe RouterModel do

  before(:all) do
    @route = RouterModel.new(stops: "china town, down town crossing")
  end

  it 'has an origin and destination' do
    expect(@route.stops.length).to eq 2
  end

  it 'has a proper nouns for origin & destination' do
    expect(@route.stops).to eq ["Chinatown", "Downtown Crossing"]
  end

  it 'has valid origins and destinations' do
    expect(@route.valid).to be_truthy
  end

end
