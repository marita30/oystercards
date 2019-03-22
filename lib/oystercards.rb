class Oystercard 

	MAXIMUM_BALANCE = 90
	MINIMUM_CHARGE = 1

	attr_reader :balance,:entry_station,:exit_station



	def initialize
		@balance = 0
		@entry_station = nil
		@exit_station = nil
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
	def touch_out(station)
		deduct(MINIMUM_CHARGE)
		@entry_station = nil
		@exit_station = station
	end

	def touch_in(station)
		fail "insufficient balance to touch in" if @balance < MINIMUM_CHARGE
		@entry_station = station
		@exit_station = nil

	end
end