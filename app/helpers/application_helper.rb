module ApplicationHelper
	def head_allow_robots?
		true
	end

	def head_title
		case params[:action]
		when 'developments'
			'Emprendimientos | Beigel Bienes Raices'
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
			if (object = @property || @development).present?
				object.title + ' | Beigel Bienes Raices'
			else
				'Ficha | Beigel Bienes Raices'
			end
		else
			if params[:controller] == 'search' && @search_filters[:operation_type] == :buy
				'Comprar | Beigel Bienes Raices'
			elsif params[:controller] == 'search' && @search_filters[:operation_type] == :rent
				'Alquilar | Beigel Bienes Raices'
			else
				'Beigel Bienes Raices'
			end
		end
	end

	def head_description
		if params[:action] == 'file' && (object = @property || @development).present?
			object.short
		else
			'Somos una empresa familiar que desde hace 45 años trabajamos arduamente para brindar el mejor servicio inmobiliario, con atención personalizada, logrando una operación a medida de cada cliente. Nos consideramos una empresa de servicios que ayuda a la gente a concretar sus proyectos.'
		end
	end

	def head_og_image
		if params[:action] == 'file' && (object = @property || @development).present?
			URI.join(request.url, object.images.first.item.url(:thumb))
		else
			asset_url 'beigel-bienes-raices.jpg'
		end
	end

	def head_og_image_width
		if params[:action] == 'file' && (object = @property || @development).present?
			'270px'
		else
			'435px'
		end
	end

	def head_og_image_height
		if params[:action] == 'file' && (object = @property || @development).present?
			'197px'
		else
			'257px'
		end
	end
end
