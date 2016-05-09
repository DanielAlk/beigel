module PropertiesHelper

	def property_step_for? status
		step = @property.errors.any? ? @property.step : params[:step]
		(status == :property && step.blank?) || step.present? && property_status_from_step(step) == status.to_s
	end

	def property_step_from_status status
		Property.steps.key(Property.statuses[status])
	end

	def property_status_from_step step
		Property.statuses.key(Property.steps[step])
	end

end
