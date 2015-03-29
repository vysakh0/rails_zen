module RailsZen::ModelLeveLValidationSpec

  def validate_belongs_to
    "it { is_expected.to belong_to(:#{name}) }"
  end
  def validate_numericality
    "it { is_expected.to validates_numericality_of(:#{name}) }"
  end
  def validate_integer
    "it { is_expected.to validates_numericality_of(:#{name}).only_integer }"
  end
end


