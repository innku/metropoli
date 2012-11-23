module Autocompleteable
  def as_json(opts={})
    opts ||={}
    super(opts.merge({ :only => [:id], :methods => [:to_s] }))
  end
end
