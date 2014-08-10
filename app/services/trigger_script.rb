class Trigger
  attr_accessor :cause, :effect
  def initialize(cause_input, *effect_methods)
    @cause = cause_input
    @effect = effect_methods
  end
  def run_trigger
    @effect.each{|script| script.run(@cause)}
  end

end
