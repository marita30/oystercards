require 'oystercards'

describe Oystercard do
	let(:station){ double :station }
	let(:entry_station){double :station}
	let(:exit_station){double :station}
	it "has a balance of zero" do
		expect(subject.balance).to eq(0)
	end

	describe '#top_up' do
		it{ is_expected.to respond_to(:top_up).with(1).argument }
		it 'can top up the balance' do
			expect{subject.top_up 1}.to change{subject.balance}.by 1
		end
		it 'raises an error if the maximum balance is exceeded' do
			maximum_balance = Oystercard::MAXIMUM_BALANCE
			subject.top_up(maximum_balance)
			expect{subject.top_up 1}.to raise_error'Maximum balance of 20 exceeded'
		end
	end

	describe '#deduct' do
	 it { is_expected.to respond_to(:deduct).with(1).argument }
		it 'deducts an amount from the balance' do
			subject.top_up(20)
			expect{ subject.deduct 3}.to change{ subject.balance }.by -3
		end
	end

	describe '#touch_in' do
		it 'is initially not in a journey' do
			expect(subject.entry_station).to eq nil
		end

		it 'can touch in' do
			subject.top_up(10)
			subject.touch_in(station)
			expect(subject).to be_in_journey
		end

		it 'will not touch in if below minimum balance' do
			expect{ subject.touch_in(station) }.to raise_error "insufficient balance to touch in"
		end

		it 'stores the entry station' do
			subject.top_up(10)
         subject.touch_in(station)
         expect(subject.entry_station).to eq station
     end
	end

	describe '#touch_out' do
		it 'can touch out' do
			subject.top_up(10)
			subject.touch_in(station)
			subject.touch_out(exit_station)
			expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(- Oystercard::MINIMUM_CHARGE)
		end
	end

	describe '#touch_in and touch_out' do
		it 'stores exit station' do
			subject.top_up(10)
			subject.touch_in(entry_station)
			subject.touch_out(exit_station)
			expect(subject.exit_station).to eq exit_station
		end
	end
 
end 