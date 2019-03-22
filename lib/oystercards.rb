class Oystercard 

	MAXIMUM_BALANCE = 90
	MINIMUM_CHARGE = 1

	attr_reader :balance


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
		@in_journey
	end
	def touch_out
		deduct(MINIMUM_CHARGE)
		@in_journey = false
	end

	def touch_in
		fail "insufficient balance to touch in" if @balance < 1
		@in_journey = true

	end
end