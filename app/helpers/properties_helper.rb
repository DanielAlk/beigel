module PropertiesHelper

	def property_step step
		params[:step].present? && Property.statuses.key(Property.steps[params[:step]]) == 'draft_' + step.to_s
	end

	def instanciate_characteristics property
		@services = []
		@extended = []
		@environments = []
		@general = []
		property.property_type.characteristics.all.each do |characteristic|
			if characteristic.available_characteristic.services?
				@services << characteristic.available_characteristic
			elsif characteristic.available_characteristic.extended?
				@extended << characteristic.available_characteristic
			elsif characteristic.available_characteristic.environments?
				@environments << characteristic.available_characteristic
			elsif characteristic.available_characteristic.general?
				@general << characteristic.available_characteristic
			end
		end
	end

end
