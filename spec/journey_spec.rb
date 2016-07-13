require 'journey'

describe Journey do

  let(:entry_station) {double(:entry_station)}
  let(:exit_station) {double(:exit_station)}

  describe '#station' do
    subject(:journey){described_class.new(entry_station: :entry_station)}
    it 'knows its entry station' do
      expect(subject.entry_station).to eq :entry_station
    end
  end

  describe '#end_journey'do
    it 'knows its exit station' do
      subject.end_journey(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

  describe '#fare' do

    it "states the journey's fare" do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      expect(subject.fare).to eq(Journey::MINIMUM_BALANCE)
    end
    it "states penalty fare if there is no recorded entry station" do
      subject.end_journey(exit_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end
     it "states penalty fare if there is no recorded exit station" do
      subject.start_journey(entry_station)
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end
  end
end
