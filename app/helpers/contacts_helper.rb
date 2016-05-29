module ContactsHelper
	def contact_subject_translate subject
	  [ :contacto, :servicios, :inversiones, :tasaciones, :eprendimiento, :inmueble ][Contact.subjects[subject]].to_s.capitalize
	end
end
