require_relative "../../../lib/service/methodical_hash"

RSpec.describe MethodicalHash do
  subject(:method_hash) { MethodicalHash.new("eins" => 1, zwei: 2) }

  it "uses the hash keys as methods" do
    expect(method_hash.eins).to eq 1
    expect(method_hash.zwei).to eq 2
  end
end
