require 'csv'

# seed doorkeeper applications
if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: "Next.js", redirect_uri: "", scopes: "")
end

# seed products
products_csv_text = File.read(Rails.root.join('db', 'products', 'products.csv'))
products_csv = CSV.parse(products_csv_text, :headers => true)

def create_or_update_products(csv)
  csv.each do |row|
    p row[0]
    product = Product.where(:name => row[0])
    if !product.empty?
      product.update!(name: row[0],
                      short_description: row['short_description']
      )
    else
      Product.create!(name: row[0],
                      short_description: row['short_description']
      )
    end
  end
  p 'Products Successfully Updated'
end

create_or_update_products(products_csv)