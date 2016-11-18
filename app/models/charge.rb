class Charge < ActiveRecord::Base

  enum period: { Monthly: 0, Quaterly: 1, Yearly: 3 }
end
