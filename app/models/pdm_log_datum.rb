class PdmLogDatum < ApplicationRecord
    self.abstract_class = true
    establish_connection :external
end
