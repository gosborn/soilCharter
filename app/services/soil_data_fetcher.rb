class SoilDataFetcher

  TODAY = (Time.now.to_f * 1000).to_i

  YESTERDAY =  (Time.now.to_i - 86400) * 1000

  def initialize
    @db = Aws::DynamoDB::Client.new
    @params = {
      table_name: "SoilData",
      projection_expression: "deviceID, published_at, #d",
      filter_expression: "published_at between :yesterday and :today",
      expression_attribute_names: {"#d" => "data"},
      expression_attribute_values: {
        ":yesterday" => YESTERDAY,
        ":today" => TODAY
      }
    }
  end

  def scan
    @db.scan(@params)
  end

  def data
    scan.items.to_json
  end
end