require "Oystercard"

describe Oystercard do
  let(:station) { double 'Kings Cross', name: 'Kings Cross'}
  let(:exit_station) { double 'Balham', name: 'Balham' }
  let(:two_journeys) { "Kings Cross to Balham\nBalham to Kings Cross" }

  context "when initialized" do
    it "set balance to zero" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    context 'with argument 20' do
      before { subject.top_up(20) }
      it 'adds 20 to balance' do
        expect(subject.balance).to be 20
      end
    end

    context 'when amount is more than maximum limit ' do
      it 'raises an error' do
        expect { (subject.top_up(subject.limit + 1)) }.to raise_error MaximumBalanceError
      end
    end
  end

  describe '#touch_in' do
    context 'when balance is less than minimum journey fare' do
      it 'raises and error' do
        expect { subject.touch_in(station) }.to raise_error LowBalanceError
      end
    end
    context 'when balance is above minimum journey fare' do
      before { subject.top_up(20) }
      it 'saves entry station' do
        expect { subject.touch_in(station) }.to change {subject.entry_station }.to (station)
        end
      end
  end

  describe '#touch_out' do
    before { subject.top_up(20); subject.touch_in(station) }

    it 'deducts minimum fare from balance' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end

    it 'saves exit station' do
      subject.touch_out(exit_station)
      expect(subject.exit_station).to be exit_station
    end
  end

  describe '#deduct' do
    before { subject.top_up(30) }

    context 'when given argument 20' do
      before { subject.send(:deduct, 20) }
      it 'deducts 20 from balance' do
        expect(subject.balance).to be 10
      end
    end
  end

  describe '#in_journey?' do
    context 'before touching in' do
      subject { described_class.new.send(:in_journey?) }
      it { is_expected.to be false }
    end

    context 'after touching in' do
      before { subject.top_up(20) }
      before { subject.touch_in(station) }

      it 'changes to true' do
        expect(subject.send(:in_journey?)).to be true
      end

      context 'then touching out' do
        before { subject.touch_out(exit_station) }
        it 'changes back to false' do
          expect(subject.send(:in_journey?)).to be false
        end
      end
    end

    describe '#journey_history' do
      before { subject.top_up(20) }

      context 'after one journey' do
        it 'prints journey history' do
          subject.touch_in(station); subject.touch_out(exit_station)
          expect(subject.journey_history).to eq "Kings Cross to Balham"
        end
      end

      context 'after 2 journeys' do
        it 'prints both' do
          subject.touch_in(station); subject.touch_out(exit_station)
          subject.touch_in(exit_station); subject.touch_out(station)
          expect(subject.journey_history).to eq two_journeys
        end
      end
    end
  end
end
