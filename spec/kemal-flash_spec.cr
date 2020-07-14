require "./spec_helper"

describe Kemal::Flash do
  it "should use flash" do
    get "/set_flash"
    headers = HTTP::Headers{"Cookie" => response.headers.get("Set-Cookie")}

    get "/use_flash", headers
    response.body.should eq("successfully created")

    get "/use_flash", headers
    response.body.should eq("")
  end

  it "should handle updates to flash" do
    get "/set_flash"
    headers = HTTP::Headers{"Cookie" => response.headers.get("Set-Cookie")}
    get "/use_flash_and_update_it", headers
    get "/flash_json", headers
    response.body.should eq("{\"notice\":\"successfully created, well done\"}")
  end

  it "should keep flash on a redirect" do
    get "/redirect"
    response.status_code.should eq(302)
    response.body.should be_empty
    headers = HTTP::Headers{"Cookie" => response.headers.get("Set-Cookie")}
    get "/flash_json", headers
    response.body.should eq("{\"notice\":\"successfully created\"}")
  end
end
