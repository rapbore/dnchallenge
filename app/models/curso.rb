class Curso < ActiveRecord::Base
	#self.table_name = "Curso"
	has_many :alumnos
	belongs_to :colegio
end
