class HTTP::Server::Context
  property! flash : Kemal::Flash::FlashHash

  def flash : Kemal::Flash::FlashHash
    @flash ||= begin
      objs = session.objects

      if objs && objs.keys.includes?("flash")
        session.object("flash").as(Kemal::Flash::FlashHash)
      else
        Kemal::Flash::FlashHash.new
      end
    end
  end

  # :nodoc:
  def commit_flash!
    session.object("flash", flash)
  end
end
