class BasePresenter
  delegate :current_user,  to: :ctrl


  def initialize(ctrl, **args)
    @ctrl = ctrl
    build_attr_readers(args)
  end

  private

  attr_reader :ctrl

  def build_attr_readers(args)
    args.each do |k, v| 
      self.class_eval("def #{k};@#{k};end")
      self.instance_variable_set("@#{k}", v)
    end
  end
end