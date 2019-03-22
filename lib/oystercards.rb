class Oystercard 

	MAXIMUM_BALANCE = 90
	MINIMUM_CHARGE = 1

	attr_reader :balance,:entry_station



	def initialize
		@balance = 0
	end

	def top_up(amount)
		fail 'Maximum balance of 20 exceeded' if amount + balance > MAXIMUM_BALANCE
		@balance += amount
	end

	def deduct(amount)
		@balance -= amount
		
	end

	def in_journey?
		!!entry_station
	end
	def touch_out
		deduct(MINIMUM_CHARGE)
		@entry_station = nil
	end

	def touch_in(station)
		fail "insufficient balance to touch in" if @balance < MINIMUM_CHARGE
		@entry_station = station

	end
end