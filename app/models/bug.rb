class Bug < ActiveRecord::Base
  before_save :def_val

  protected
  def def_val
    self.finished ||= 0
  end

end
