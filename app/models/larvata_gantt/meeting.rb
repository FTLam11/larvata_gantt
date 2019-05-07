module LarvataGantt
  class Meeting < BasicTask
    include LarvataGantt::Durationable

    validates_presence_of :details

    def post_initialize(*)
      nil
    end
  end
end
