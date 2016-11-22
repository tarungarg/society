class Rent < ActiveRecord::Base
  enum flat_types: { Sale: 0, Rent: 1 }
  enum sale_bys: { Owner: 0, Agent: 1, Other: 2 }

end
