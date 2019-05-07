module LarvataGantt
  class Milestone < BasicTask
    include LarvataGantt::Durationable

    def post_initialize(*)
      nil
    end
  end
end
