json.array!(@alumnos) do |alumno|
  json.extract! alumno, :id, :nombre, :curso_id, :numero
  json.url alumno_url(alumno, format: :json)
end
