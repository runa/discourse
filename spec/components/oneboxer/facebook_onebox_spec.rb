# encoding: utf-8

require 'spec_helper'
require 'oneboxer'
require 'oneboxer/amazon_onebox'

describe Oneboxer::FacebookOnebox do
  before(:each) do
    @o = Oneboxer::FacebookOnebox.new("https://www.facebook.com/ArepasLaJuanita")
    FakeWeb.register_uri(:get, @o.translate_url, response: fixture_file('oneboxer/facebook.response'))
  end

  it "translates the URL" do
    @o.translate_url.should == "http://graph.facebook.com/ArepasLaJuanita"
  end

  it "generates the expected onebox for Facebook" do
    @o.onebox.should match_html expected_facebook_result
  end

private
  def expected_facebook_result
    <<EXPECTED
<div class='onebox-result'>
    <div class='source'>
      <div class='info'>
        <a href='https://www.facebook.com/ArepasLaJuanita' class="track-link" target="_blank">
          <img class='favicon' src="/assets/favicons/facebook.png"> facebook.com
        </a>
      </div>
    </div>
  <div class='onebox-result-body'>
    <img src="http://sphotos-c.ak.fbcdn.net/hphotos-ak-prn1/s720x720/1010918_541800915877822_1282590823_n.jpg" class="thumbnail">
    <h3><a href="https://www.facebook.com/ArepasLaJuanita" target="_blank">Arepas La Juanita</a></h3>
    
      Ricas arepas colombianas de puro maíz, elaboración artesanal.
Buenos Aires, Argentina
Arepas medianas amarillas, paquete x 5 unidades.
Arepas medianas blancas, paquete x 5 unidades. 

  </div>
  <div class='clearfix'></div>
</div>
EXPECTED
  end
end
