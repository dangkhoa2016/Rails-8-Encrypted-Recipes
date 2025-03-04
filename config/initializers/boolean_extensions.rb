module BooleanExtensions
  def to_yes_no
    self ? 'Yes' : 'No'
  end
end

class TrueClass
  include BooleanExtensions
end

class FalseClass
  include BooleanExtensions
end

class NilClass
  include BooleanExtensions
end
