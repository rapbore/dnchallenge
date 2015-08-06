class Colegio < ActiveRecord::Base
	#self.table_name = "Colegio"
	has_many :cursos
end
