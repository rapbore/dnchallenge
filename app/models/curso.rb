class Curso < ActiveRecord::Base
	has_many :alumnos
	belongs_to :colegio
end
