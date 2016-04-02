module ApplicationHelper
	def head_allow_robots?
		true
	end

	def head_title
		case params['action']
		when 'developments'
			'Emprendimientos | Beigel Bienes Raices'
		when 'buy'
			'Comprar | Beigel Bienes Raices'
		when 'rent'
			'Alquilar | Beigel Bienes Raices'
		when 'friends'
			'Empresas amigas | Beigel Bienes Raices'
		when 'about'
			'La Empresa | Beigel Bienes Raices'
		when 'contact'
			'Contacto | Beigel Bienes Raices'
		when 'services'
			'Servicios | Beigel Bienes Raices'
		when 'assessments'
			'Tasaciones | Beigel Bienes Raices'
		when 'investments'
			'Inversiones | Beigel Bienes Raices'
		when 'file'
			'Ficha Técnica | Beigel Bienes Raices'
		else
			'Beigel Bienes Raices'
		end
	end

	def head_description
		''
	end

	def head_og_image
		''
	end

	def nav_class(action = nil)
		if action.kind_of? Array
			'active' if action.include? params['action'].to_sym
		else
			'active' if action.to_s == params['action']
		end
	end
end
