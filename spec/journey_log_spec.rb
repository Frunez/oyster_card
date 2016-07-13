require 'journey_log'

describe JourneyLog do

let(:journey_class) {double(:journey_class)}
let(:entry_station) {double(:entry_station)}

  describe '#start' do
    subject(:journey_class){described_class(journey_class: :journey_class)}
    it 'should start a journey with an entry station' do
      expect(subject.start(entry_station)).to eq :entry_station
    end
  end
end
