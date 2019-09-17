class Pages
  attr_accessor :login, :code, :journey, :request

  def initialize
    @login   = LoginPage.new
    @code    = CodePage.new
    @journey = JourneyPage.new
    @request = RequestCarPage.new
  end
end