module RailsZen::ModelLeveLValidation

  def validate_belongs_to
    ""
  end
  def validate_numericality
     ", numericality: true"
  end
  def validate_integer
    ", numericality: { only_integer: true }"
  end
end
