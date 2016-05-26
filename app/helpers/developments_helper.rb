module DevelopmentsHelper

	def development_step_for? status
		step = @development.errors.any? ? @development.step : params[:step]
		(status == :development && step.blank?) || step.present? && development_status_from_step(step) == status.to_s
	end

	def development_step_from_status status
		Development.steps.key(Development.statuses[status])
	end

	def development_status_from_step step
		Development.statuses.key(Development.steps[step])
	end

end
