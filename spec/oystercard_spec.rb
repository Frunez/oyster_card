require 'oystercard'

describe Oystercard do

  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  context '#balance' do

    it 'should initialize with 0' do
      expect(subject.balance).to eq 0
    end

    describe '#top_up' do
      it 'should update the balance with top_up' do
        expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
      end
      it 'raises an error if balance limit is over' do
        top_up_limit = Oystercard::TOP_UP_LIMIT
        subject.top_up(top_up_limit)
        expect{ subject.top_up(1) }.to raise_error "Top up limit of #{top_up_limit} exceeded"
      end
    end

  end

  context 'in journey' do

    describe '#in_journey?' do
      it 'should return false when initialized' do
        expect(subject).not_to be_in_journey
      end
    end
  end

  context 'touch_in and touch_out' do

      it 'should raise error if balance is less than minimum' do
        expect{ subject.touch_in!(entry_station) }.to raise_error 'Balance too low, please top up your card'
      end
    describe '#touch_in!' do
      before do
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in!(entry_station)
      end
      it 'should change #in_journey to be true' do
        expect(subject).to be_in_journey
      end
      it 'should deduct the minimum fare from balance' do
        expect{ subject.touch_out!(exit_station) }.to change{ subject.balance }.by (-(Oystercard::MINIMUM_BALANCE))
      end
    end
    describe '#touch_out!' do
      before do
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in!(entry_station)
        subject.touch_out!(exit_station)
      end
      it 'should change #in_journey to be false' do
        expect(subject).not_to be_in_journey
      end
    end
  end

    describe '#store_journey' do
      it 'starts with no journeys on the card' do
        expect(subject.journey_history).to be_empty
      end
    end

    describe 'journey history after one journey' do
      before do
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in!(entry_station)
        subject.touch_out!(exit_station)
      end
      it 'should add one journey after touch in & touch out' do
        expect(subject.journey_history).not_to be_empty
      end
    end
end
