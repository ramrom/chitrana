class EISSource < ActiveRecord::Base
  establish_connection :eis
end
