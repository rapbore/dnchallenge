class Alumno < ActiveRecord::Base
	#self.table_name = "Alumno"
	belongs_to :curso
end
